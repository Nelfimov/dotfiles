return {
  "obsidian-nvim/obsidian.nvim",
  ft = "markdown",
  keys = {
    { "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Obsidian backlinks" },
    { "<leader>od", "<cmd>Obsidian dailies<cr>", desc = "Obsidian dailies" },
    { "<leader>of", "<cmd>Obsidian quick_switch<cr>", desc = "Obsidian find note" },
    { "<leader>ol", "<cmd>Obsidian links<cr>", desc = "Obsidian links" },
    { "<leader>on", "<cmd>Obsidian new<cr>", desc = "Obsidian new note" },
    { "<leader>oo", "<cmd>Obsidian open<cr>", desc = "Open in Obsidian" },
    { "<leader>op", "<cmd>Obsidian paste_img<cr>", desc = "Obsidian paste image" },
    { "<leader>or", "<cmd>Obsidian rename<cr>", desc = "Obsidian rename note" },
    { "<leader>os", "<cmd>Obsidian search<cr>", desc = "Obsidian search" },
    { "<leader>ot", "<cmd>Obsidian today<cr>", desc = "Obsidian today" },
    { "<leader>oT", "<cmd>Obsidian template<cr>", desc = "Obsidian template" },
    { "<leader>ow", "<cmd>Obsidian workspace<cr>", desc = "Obsidian workspace" },
    { "<leader>oy", "<cmd>Obsidian yesterday<cr>", desc = "Obsidian yesterday" },
    { "<leader>oL", ":Obsidian link<cr>", mode = "v", desc = "Obsidian link selection" },
    { "<leader>oN", ":Obsidian link_new<cr>", mode = "v", desc = "Obsidian link new note" },
    { "<leader>oe", ":Obsidian extract_note<cr>", mode = "v", desc = "Obsidian extract note" },
  },
  opts = {
    legacy_commands = false,
    ui = {
      enable = false,
    },
    checkbox = {
      order = { " ", "x" },
    },
    callbacks = {
      enter_note = function()
        vim.opt_local.spell = false

        vim.keymap.set("n", "<leader>oa", require("obsidian.api").smart_action, {
          buffer = true,
          desc = "Obsidian smart action",
        })
        vim.keymap.set("n", "<leader>oc", "<cmd>Obsidian toggle_checkbox<cr>", {
          buffer = true,
          desc = "Obsidian toggle checkbox",
        })
      end,
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
