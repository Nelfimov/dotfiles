return {
  "amekusa/auto-input-switch.nvim",
  opts = {
    os_settings = { macos = { cmd_get = "macism", cmd_set = "macism %s" } },
    match = {
      enable = true,
      languages = {
        Ru = { enable = true, priority = 0 },
      },
    },
    restore = {
      enable = false,
    },
  },
}
