local exclude_list =
  { ".yarn", "node_modules", ".pnp.cjs", "dist", ".ansible", ".DS_Store", ".localized", "yarn.lock", "target" }

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
      formatters = { file = { truncate = 80 } },
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
          hidden = false,
          ignored = true,
          exclude = { ".git", ".DS_Store", ".localized" },
          layout = {
            preview = { main = true, enabled = false },
            layout = {
              width = 0.2,
              min_width = 100,
            },
          },
        },
      },
    },
  },
}
