return {
  "obsidian-nvim/obsidian.nvim",
  ft = "markdown",
  opts = {
    legacy_commands = false,
    ui = {
      enable = false,
    },
    checkbox = {
      order = { " ", "x" },
    },
    callbacks = {
      enter_note = function()
        vim.opt_local.spell = false
      end,
    },
    workspaces = {
      {
        name = "index",
        path = "~/Documents/Dev/Obsidian",
        strict = true,
      },
    },
    picker = {
      name = "snacks.pick",
    },
  },
}
