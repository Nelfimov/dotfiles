local Utils = require("adapters.core.utils")
local lib = require("neotest.lib")

local Spec = {}

---Create execution command
---@param args any
---@return table
function Spec.build_spec(args)
  local file_path = args.tree:data().path
  local command
  local env = {}
  local yarn_version = Utils.get_yarn_version()
  if Utils.is_yarn_atls(yarn_version) then
    command = {
      "yarn",
      "test",
      "--test-reporter=tap",
      file_path,
    }
  elseif Utils.is_yarn_raijin(yarn_version) then
    local rootPath = lib.files.match_root_pattern(".git")(args[1])
    io.popen("source " .. rootPath .. "/.env && export NODE_OPTIONS")
    env.NODE_OPTIONS = "-r "
      .. rootPath
      .. "/.pnp.cjs --loader "
      .. rootPath
      .. "/.pnp.loader.mjs --experimental-vm-modules --max-old-space-size=8192 --no-warnings=ExperimentalWarning"
    command = {
      "yarn",
      "test",
      "--test-reporter=tap",
      file_path,
    }
  else
    command = {
      "node",
      "--experimental-strip-types",
      "--experimental-transform-types",
      "--test",
      "--no-warnings=ExperimentalWarning",
      "--test-reporter=tap",
      file_path,
    }
  end

  vim.notify(vim.inspect(env))

  return {
    command = command,
    env = env,
    context = args.tree:data(),
    cwd = vim.fn.getcwd(),
  }
end

return Spec
