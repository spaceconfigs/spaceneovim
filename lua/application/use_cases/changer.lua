local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
  return require("infrastructure.adapters.changer")
end

M.list = function()
  local adapter = M.setup()

  adapter.list()
end

return make_logged("use_cases/changer", M)
