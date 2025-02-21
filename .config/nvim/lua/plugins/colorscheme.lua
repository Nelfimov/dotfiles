return {
  {
    "Mofiqul/dracula.nvim",
    opts = {
      italic_comment = true,
      overrides = function(colors)
        return {
          NonText = { fg = colors.comment },
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
