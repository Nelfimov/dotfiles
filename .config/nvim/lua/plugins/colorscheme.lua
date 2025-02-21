return {
  {
    "Mofiqul/dracula.nvim",
    opts = {
      italic_comments = true,
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
