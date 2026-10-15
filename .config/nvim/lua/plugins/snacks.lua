local exclude_list = {
  ".yarn",
  "node_modules",
  ".pnp.cjs",
  "dist",
  ".ansible",
  ".DS_Store",
  ".localized",
  "yarn.lock",
  "*.lock",
  "target",
  "tmp",
  "public/assets",
  "log",
  "venv",
  ".venv",
  ".idea",
  "vendor",
  ".direnv",
}

return {
  "folke/snacks.nvim",
  opts = {
    image = {
      enabled = true,
    },
    dashboard = {
      preset = {
        header = [[]],
      },
    },
    gitbrowse = {
      url_patterns = {
        ["gitlab%.rees46%.ru"] = {
          branch = "/-/tree/{branch}",
          file = "/-/blob/{branch}/{file}#L{line_start}-{line_end}",
          permalink = "/-/blob/{commit}/{file}#L{line_start}-{line_end}",
          commit = "/-/commit/{commit}",
        },
      },
    },
    zen = {
      toggles = { dim = false },
      win = { backdrop = { transparent = false } },
    },
    explorer = {},
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
