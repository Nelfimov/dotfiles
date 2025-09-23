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
    },
    follow_url_func = function(url)
      vim.fn.jobstart({ "open", url })
    end,
    picker = {
      name = "snacks.pick",
    },
  },
}
