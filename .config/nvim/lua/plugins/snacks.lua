local exclude_list = { ".yarn", "node_modules", ".pnp.cjs", "dist", ".ansible", ".DS_Store", ".localized" }

return {
  "folke/snacks.nvim",
  ---@type snacks.picker.Config
  opts = {
    picker = {
      sources = {
        files = {
          hidden = true,
          ignored = true,
          exclude = exclude_list,
        },
        grep = {
          hidden = true,
          ignored = true,
          exclude = exclude_list,
        },
        explorer = {
          hidden = true,
          ignored = true,
          exclude = { ".git", ".DS_Store", ".localized" },
        },
      },
    },
  },
}
