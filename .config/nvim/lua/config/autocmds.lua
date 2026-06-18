-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable autoformat for lua files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "ruby", "rb" },
  callback = function()
    vim.b.autoformat = false
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "ObsidianNoteWritePost",
  callback = (function()
    local vault = vim.fn.expand("~/Documents/Dev/Obsidian")
    local uv = vim.uv or vim.loop
    local timer
    local running = false
    local rerun = false

    local function notify(msg, level)
      vim.schedule(function()
        vim.notify(msg, level or vim.log.levels.INFO, { title = "Obsidian Git" })
      end)
    end

    local function sync()
      if running then
        rerun = true
        return
      end

      running = true
      local timestamp = os.date("%Y-%m-%d %H:%M:%S")
      local script = table.concat({
        "set -e",
        "git add -A",
        "if ! git diff --cached --quiet; then",
        string.format("git commit -m %q", "vault: " .. timestamp),
        "fi",
        "git push",
      }, "\n")

      vim.fn.jobstart({ "sh", "-c", script }, {
        cwd = vault,
        on_exit = function(_, code)
          running = false
          if code ~= 0 then
            notify("autocommit failed, exit code " .. code, vim.log.levels.ERROR)
          elseif rerun then
            rerun = false
            sync()
          end
        end,
      })
    end

    local function schedule_sync()
      if timer then
        timer:stop()
        timer:close()
      end

      timer = uv.new_timer()
      timer:start(
        3000,
        0,
        vim.schedule_wrap(function()
          timer:stop()
          timer:close()
          timer = nil
          sync()
        end)
      )
    end

    return function(ev)
      local file = vim.api.nvim_buf_get_name(ev.buf or 0)
      if not vim.startswith(vim.fs.normalize(file), vim.fs.normalize(vault) .. "/") then
        return
      end

      schedule_sync()
    end
  end)(),
})
