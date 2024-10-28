local make_controller_logged = require("application.helpers.make_controller_logged")
local rest_use_case = require("application.ports.use_case_registry").rest()

---@type RestContract
local M = {
  open = function()
    return function()
      rest_use_case.open()
    end
  end,

  send = function()
    return function()
      rest_use_case.send()
    end
  end,

  replay = function()
    return function()
      rest_use_case.replay()
    end
  end,
}

return make_controller_logged("rest", M)
