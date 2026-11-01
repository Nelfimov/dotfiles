-- Rex reads this on `rex config reload`. The actions show in the command
-- palette and run with `rex do NAME`. Keys follow herdr: ctrl+b prefix.
local terminal = "com.superlogical.terminal"

rex.bind("cmd+shift+h", "pane.split", { direction = "left" })
rex.bind("cmd+shift+j", "pane.split", { direction = "down" })
rex.bind("cmd+shift+k", "pane.split", { direction = "up" })
rex.bind("cmd+shift+l", "pane.split", { direction = "right" })

rex.bind("cmd+alt+h", "pane.focus", { direction = "left" })
rex.bind("cmd+alt+j", "pane.focus", { direction = "down" })
rex.bind("cmd+alt+k", "pane.focus", { direction = "up" })
rex.bind("cmd+alt+l", "pane.focus", { direction = "right" })

-- The focused pane's folder: what its shell last reported (OSC 7), else
-- where its foreground process is.
local function pane_dir(ctx)
	if not ctx.block_id then
		return nil
	end
	local target = { session_id = ctx.session_id, block_id = ctx.block_id }
	local status = rex.block.call(terminal, "pwd", target)
	local path = status and status.pwd or ""
	path = path:match("^file://[^/]*(/.*)$") or path
	path = path:gsub("%%(%x%x)", function(hex)
		return string.char(tonumber(hex, 16))
	end)
	if path ~= "" then
		return path
	end
	local proc = rex.block.call(terminal, "process", target)
	return proc and proc.foreground and proc.foreground.cwd or nil
end

-- A command in a floating pane over the window, like a tmux popup. The
-- pane closes when the command exits.
local function popup(label, command, bounds, cwd)
	local layer, err = rex.session.new_layer({
		bounds = bounds,
		focus = true,
		layout = rex.layout.block({
			flavor = terminal .. ".shell",
			label = label,
			options = { command = command, cwd = cwd, exit = { on_completion = true } },
		}),
	})
	if err ~= nil then
		error(err, 0)
	end
	return { layer_id = layer.layer_id }
end

-- Copy mode: the pane's scrollback in nvim over the window, at the end.
-- Search, yank and page there; q quits. Rex has no scroll action of its own.
local function scrollback(ctx)
	local target = { session_id = ctx.session_id, block_id = ctx.block_id }
	local args = { format = "text", trim = true, unwrap = true, max_bytes = 983040 }
	for k, v in pairs(target) do
		args[k] = v
	end
	local r, err = rex.block.call(terminal, "format", args)
	if not r then
		error(err, 0)
	end
	local parts, offset = { r.content }, #r.content
	while r.id and not r.eof do
		r, err = rex.block.call(
			terminal,
			"blob_read",
			{ session_id = ctx.session_id, block_id = ctx.block_id, id = r.id, offset = offset }
		)
		if not r then
			error(err, 0)
		end
		parts[#parts + 1] = r.data
		offset = offset + #r.data
	end
	return table.concat(parts)
end

rex.action({
	name = "copy_mode",
	title = "Copy Mode",
	keywords = "scrollback history copy yank search",
	run = function(ctx)
		if not ctx.block_id then
			error("Copy Mode: no focused pane", 0)
		end
		local path = os.tmpname()
		local f = assert(io.open(path, "w"))
		f:write(scrollback(ctx))
		f:close()
		local nvim = 'nvim -R -c "normal! G" -c "nnoremap <buffer> q <Cmd>qa!<CR>" "$1"; rm -f "$1"'
		return popup("copy", { "sh", "-c", nvim, "sh", path }, { 0, 0, 1, 1 }, pane_dir(ctx))
	end,
})

rex.bind("cmd+f", "copy_mode")
