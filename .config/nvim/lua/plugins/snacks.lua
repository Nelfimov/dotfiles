local exclude_list = { ".yarn", "node_modules", ".pnp.cjs", "dist", ".ansible" }

return {
  "folke/snacks.nvim",
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
          exclude = { ".git" },
        },
      },
    },
  },
}
