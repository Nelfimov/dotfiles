-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set

map({ "n", "x" }, "<leader>gB", function()
  Snacks.gitbrowse({ what = "permalink" })
end, { desc = "Git Browse (open permalink)" })

map({ "n", "x" }, "<leader>gY", function()
  Snacks.gitbrowse({
    what = "permalink",
    open = function(url)
      vim.fn.setreg("+", url)
    end,
    notify = false,
  })
end, { desc = "Git Browse (copy permalink)" })
