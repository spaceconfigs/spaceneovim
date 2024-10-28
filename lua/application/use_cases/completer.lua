local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
  return require("infrastructure.adapters.completer")
end

M.complete = function()
  local adapter = M.setup()

  adapter.complete()
end

return make_logged("use_cases/completer", M)
