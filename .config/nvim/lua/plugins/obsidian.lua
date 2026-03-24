return {
  "obsidian-nvim/obsidian.nvim",
  ft = "markdown",
  opts = {
    checkbox = {
      order = { " ", "x" },
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
