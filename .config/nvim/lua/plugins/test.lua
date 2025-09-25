return {
  {
    "nvim-neotest/neotest-plenary",
  },
  {
    "nvim-neotest/neotest",
    dependencies = { "Nelfimov/neotest-node-test-runner" },
    opts = function()
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
