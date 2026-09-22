return {
  {
    "nvim-neotest/neotest-plenary",
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "Nelfimov/neotest-node-test-runner",
      "olimorris/neotest-rspec",
      "volodya-lombrozo/neotest-ruby-minitest",
    },
    opts = function()
      return {
        adapters = {
          require("adapters"), -- Подключаем локальный адаптер
          -- ["neotest-node-test-runner"] = {},
          require("neotest-ruby-minitest"),
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
  },
}
