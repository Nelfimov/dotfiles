local exclude_list = { ".yarn", "node_modules", ".pnp.cjs", "dist", ".ansible", ".DS_Store", ".localized" }

return {
  "folke/snacks.nvim",
  opts = {
    zen = {
      toggles = { dim = false },
      win = { backdrop = { transparent = false } },
    },
    explorer = {},
    ---@type snacks.picker.Config
    picker = {
      layouts = {},
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
          layout = {
            preview = { main = true, enabled = false },
          },
        },
      },
    },
  },
}
