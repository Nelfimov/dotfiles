return {
  {
    "Mofiqul/dracula.nvim",
    ---@module 'dracula'
    ---@type DraculaConfig
    opts = {
      italic_comment = true,
      overrides = function(colors)
        return {
          SnacksPickerDir = { fg = colors.comment },
          SnacksPickerPathHidden = { fg = colors.comment },
          SnacksPickerPathIgnored = { fg = colors.comment },
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
