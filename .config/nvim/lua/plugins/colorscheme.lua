return {
  {
    "Mofiqul/dracula.nvim",
    opts = {
      italic_comments = true,
      overrides = function(colors)
        return {
          SnacksPickerDir = { fg = colors.comment },
          SnacksPickerPathHidden = { fg = colors.fg },
          SnacksPickerPathIgnored = { fg = colors.fg },
        }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  },
}
