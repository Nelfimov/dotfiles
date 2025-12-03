return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      rust = { "rustfmt", lsp_format = "fallback", default_edition = "2024" },
      liquid = { "prettier" },
      ruby = { formatter },
      eruby = { "erb_format" },
      nginx = { "nginx-config-formatter" },
    },
    formatters = {
      rustfmt = {
        prepend_args = { "--unstable-features" },
      },
      prettier = {
        ext_parsers = {
          liquid = "html",
        },
        args = function(self, ctx)
          local check_cwd = require("conform.util").root_file({
            ".prettierrc",
            ".prettierrc.json",
            ".prettier.yml",
            ".prettierrc.yml",
            ".prettier.yaml",
            ".prettierrc.yaml",
            ".prettierrc.json5",
            ".prettierrc.js",
            ".prettierrc.cjs",
            ".prettierrc.mjs",
            ".prettierrc.toml",
            "prettier.config.js",
            "prettier.config.cjs",
            "prettier.config.mjs",
          })

          local has_cwd = check_cwd(self, ctx) ~= nil

          if not has_cwd then
            return {
              "--stdin-filepath",
              "$FILENAME",
              "--config",
              "/Users/nelfimov/Documents/Dev/dotfiles/.config/nvim/config/.prettier.yaml",
            }
          end

          return { "--stdin-filepath", "$FILENAME" }
        end,
      },
    },
  },
}
