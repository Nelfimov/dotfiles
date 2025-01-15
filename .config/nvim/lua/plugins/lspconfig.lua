return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local function path_exists(project_root, path)
      return vim.loop.fs_stat(project_root or "" .. path) ~= nil
    end

    local project_root = require("lspconfig.util").root_pattern(".git")(vim.fn.getcwd())
    local tsdk_path = "/.yarn/sdks/typescript/lib"

    if path_exists(project_root, tsdk_path) then
      opts.servers.vtsls.settings.typescript.tsdk = project_root .. tsdk_path
      opts.servers.vtsls.init_options = { hostInfo = "neovim" }
    end

    opts.autoformat = false

    local function find_terraform_root(fname)
      local root = require("lspconfig.util").root_pattern(".terraform", ".terraform.lock.hcl")(fname)
      return root or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
    end

    opts.servers.terraformls = opts.servers.terraformls or {}
    opts.servers.terraformls.root_dir = find_terraform_root

    opts.servers.yamlls.settings = {
      yaml = {
        schemas = {
          kubernetes = "{specs,spec}/**/*.{yaml,yml}",
          ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*{yaml,yml}",
          ["https://json.schemastore.org/github-action.json"] = ".github/actions/*.{yaml,yml}",
          ["https://json.schemastore.org/github-issue-forms.json"] = ".github/ISSUE_TEMPLATE/.{yaml,yml}",
          ["https://json.schemastore.org/github-issue-config.json"] = ".github/ISSUE_TEMPLATE/config.{yaml,yml}",
          ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.{yaml,yml}",
        },
      },
    }
  end,
}
