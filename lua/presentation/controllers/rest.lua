local make_controller_logged = require("application.helpers.make_controller_logged")
local rest_usecase = require("application.ports.usecase_registry").rest()

---@type RestContract
local M = {
  open = function()
    return function()
      rest_usecase.open()
    end
  end,

  send = function()
    return function()
      rest_usecase.send()
    end
  end,

  replay = function()
    return function()
      rest_usecase.replay()
    end
  end,
}

return make_controller_logged("rest", M)
