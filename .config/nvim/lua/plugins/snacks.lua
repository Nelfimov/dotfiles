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
  ".gem_rbs_collection",
}

local function checkout_commit(picker, item)
  picker:close()

  if not item or not item.commit then
    return
  end

  Snacks.picker.util.cmd({ "git", "checkout", "--detach", item.commit }, function()
    Snacks.notify("Checkout " .. item.commit, { title = "Git" })
    vim.cmd.checktime()
  end, { cwd = item.cwd })
end

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
        git_log_file = {
          confirm = "git_checkout",
          actions = {
            checkout_commit = checkout_commit,
          },
          win = {
            input = {
              keys = {
                ["<S-CR>"] = { "checkout_commit", mode = { "n", "i" } },
              },
            },
            list = {
              keys = {
                ["<S-CR>"] = { "checkout_commit", mode = { "n", "x" } },
              },
            },
          },
        },
      },
    },
  },
}
