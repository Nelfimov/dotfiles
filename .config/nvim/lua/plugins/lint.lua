return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters_by_ft = {
      php = { "phpcs", "phpstan" },
      markdown = { "markdownlint-cli2" },
    },
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", vim.fn.stdpath("config") .. "/markdownlint.json" },
      },
    },
  },
}
