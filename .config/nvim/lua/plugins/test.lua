return {
  {
    "nvim-neotest/neotest-plenary",
  },
  {
    "nvim-neotest/neotest",
    dependencies = { "Nelfimov/neotest-node-test-runner" },
    opts = function()
      local neotest = require("neotest")
      return {
        adapters = {
          require("adapters"), -- Подключаем локальный адаптер
        },
      }
    end,
    -- opts = {
    --   adapters = { ["neotest-node-test-runner"] = {} },
    -- },
  },
}
