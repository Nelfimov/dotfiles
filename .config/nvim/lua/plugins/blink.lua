return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      ["<C-n>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
    },
  },
}
