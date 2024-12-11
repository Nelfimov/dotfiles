return {
  {
    "nvim-neotest/neotest-plenary",
  },
  {
    "nvim-neotest/neotest",
    dependencies = { "Nelfimov/neotest-node-test-runner" },
    opts = {
      adapters = { ["neotest-node-test-runner"] = {} },
    },
  },
}
