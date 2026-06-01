local function snacks_explorer_dir()
  local ok, snacks = pcall(require, "snacks")
  local Snacks = ok and snacks or _G.Snacks
  if not Snacks or not Snacks.picker then
    return vim.uv.cwd()
  end

  local picker = Snacks.picker.get({ source = "explorer", tab = false })[1]
  if not picker then
    return vim.uv.cwd()
  end

  local current_win = vim.api.nvim_get_current_win()
  local explorer_win = picker.list and picker.list.win and picker.list.win.win
  if explorer_win ~= current_win then
    return vim.uv.cwd()
  end

  local ok_dir, dir = pcall(function()
    return picker:dir()
  end)
  if ok_dir and dir then
    return dir
  end

  return vim.uv.cwd()
end

return {
  "dmtrKovalenko/fff.nvim",
  build = function()
    require("fff.download").download_or_build_binary()
  end,
  opts = {
    keymaps = {
      close = "<Esc><Esc>",
    },
    layout = {
      prompt_position = "top",
    },
    git = {
      status_text_color = true,
    },
    logging = {
      enabled = false,
    },
  },
  lazy = false, -- the plugin lazy-initialises itself
  keys = {
    {
      "<leader><leader>",
      function()
        local cwd = snacks_explorer_dir()
        vim.notify(vim.inspect(cwd))
        if cwd then
          require("fff").find_files_in_dir(cwd)
        else
          require("fff").find_files()
        end
      end,
      desc = "FFFind files",
    },
    {
      "<leader>fF",
      function()
        local cwd = snacks_explorer_dir()
        vim.notify(vim.inspect(cwd))
        if cwd then
          require("fff").find_files_in_dir(cwd)
        else
          require("fff").find_files()
        end
      end,
      desc = "FFFind files",
    },
    {
      "<leader>/",
      function()
        local cwd = snacks_explorer_dir()
        vim.notify(vim.inspect(cwd))
        require("fff").live_grep({ cwd = cwd })
      end,
      desc = "LiFFFe grep",
    },
    {
      "<leader>fz",
      function()
        require("fff").live_grep({ grep = { modes = { "fuzzy", "plain" } } })
      end,
      desc = "Live fffuzy grep",
    },
    {
      "<leader>fc",
      function()
        require("fff").live_grep({ query = vim.fn.expand("<cword>") })
      end,
      desc = "Search current word",
    },
  },
}
