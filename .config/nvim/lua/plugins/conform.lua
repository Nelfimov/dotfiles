return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      prettier = {
        preprend_args = function(self, ctx)
          local check_cwd = require("conform.util").root_file({
            ".prettierrc",
            ".prettierrc.json",
            ".prettierrc.yml",
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
            return { "--config", "~/.config/nvim/config/.prettier.yaml" }
          end
        end,
      },
    },
  },
}
