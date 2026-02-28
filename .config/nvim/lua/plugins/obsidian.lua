return {
  "obsidian-nvim/obsidian.nvim",
  ft = "markdown",
  opts = {
    workspaces = {
      {
        name = "work",
        path = "~/Documents/Dev/Obsidian/work",
        strict = true,
      },
      {
        name = "travel",
        path = "~/Documents/Dev/Obsidian/travel",
        strict = true,
      },
    },
    picker = {
      name = "snacks.pick",
    },
  },
}
