return {
  "obsidian-nvim/obsidian.nvim",
  ft = "markdown",
  cond = function()
    local cwd = vim.fn.getcwd()
    local target = "~/Documents/Dev/Obsidian"
    return vim.startswith(cwd, target)
  end,
  opts = {
    workspaces = {
      {
        name = "work",
        path = "~/Documents/Dev/Obsidian/work",
        strict = true,
      },
    },
    picker = {
      name = "snacks.pick",
    },
  },
}
