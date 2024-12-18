return {
  "ibhagwan/fzf-lua",
  opts = function(_, opts)
    local fd_additions = " --hidden --exclude .git --exclude .yarn --exclude dist"
    local rg_additions =
      " --hidden --glob '!**/{.yarn,.git,dist,node_modules}/**' --glob '!**/.pnp*js' --glob '!**/*.lock'"

    if opts.grep.rg_opts then
      opts.grep.rg_opts = opts.grep.rg_opts .. rg_additions
    else
      opts.grep.rg_opts = "--column --line-number --hidden --ignore-case --no-heading --color=always --smart-case --trim"
        .. rg_additions
    end

    if opts.files.fd_opts then
      opts.files.fd_opts = opts.files.fd_opts .. fd_additions
    else
      opts.files.fd_opts = "--type f --follow" .. fd_additions
    end

    return opts
  end,
}
