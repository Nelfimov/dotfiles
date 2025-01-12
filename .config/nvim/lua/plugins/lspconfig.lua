return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local nvim_lsp = require("lspconfig.util")

    local function path_exists(project_root, path)
      return vim.loop.fs_stat(project_root .. path) ~= nil
    end

    local project_root = nvim_lsp.root_pattern(".git")(vim.fn.getcwd())
    local tsdk_path = "/.yarn/sdks/typescript/lib"

    if path_exists(project_root, tsdk_path) then
      opts.servers.vtsls.settings.typescript.tsdk = project_root .. tsdk_path
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
