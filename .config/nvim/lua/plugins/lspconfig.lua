return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local tsdk_path = "./.yarn/sdks/typescript/lib"

    local function path_exists(path)
      return vim.loop.fs_stat(path) ~= nil
    end

    if path_exists(tsdk_path) then
      opts.servers.vtsls.settings.typescript.tsdk = tsdk_path
      opts.servers.vtsls.init_options = { hostInfo = "neovim" }
    end

    opts.autoformat = false

    local function find_terraform_root(fname)
      local root = require("lspconfig.util").root_pattern(".terraform", ".terraform.lock.hcl")(fname)
      return root or require("lspconfig.util").find_git_ancestor(fname)
    end

    opts.servers.terraformls = opts.servers.terraformls or {}
    opts.servers.terraformls.root_dir = find_terraform_root
  end,
}
