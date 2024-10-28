local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
  return require("application.ports.registry").completer()
end

M.complete = function()
  local adapter = M.setup()

  adapter.complete()
end

return make_logged("usecases/completer", M)
