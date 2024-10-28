---@type CompleterUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
  setup = function()
    return require("application.ports.adapter_registry").completer()
  end,

  complete = function()
    local adapter = M.setup()

    adapter.complete()
  end,
}

return make_logged("usecases/completer", M)
