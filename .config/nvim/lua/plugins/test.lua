return {
  {
    "nvim-neotest/neotest-plenary",
  },
  {
    "nvim-neotest/neotest",
    dependencies = { "Nelfimov/neotest-node-test-runner", "olimorris/neotest-rspec" },
    opts = function()
      return {
        adapters = {
          require("adapters"), -- Подключаем локальный адаптер
          ["rustaceanvim.neotest"] = {},
          ["neotest-rspec"] = {
            rspec_cmd = function()
              return vim.tbl_flatten({
                "bundle",
                "exec",
                "rspec",
              })
            end,
          },
        },
      }
    end,
    -- opts = {
    --   adapters = { ["neotest-node-test-runner"] = {} },
    -- },
  },
}
