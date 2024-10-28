local make_controller_logged = require("application.helpers.make_controller_logged")
local zen_usecase = require("application.ports.use_case_registry").zen()

---@type ZenContract
local M = {
  toggle = function()
    return function()
      zen_usecase.toggle()
    end
  end,

  center = function()
    return function()
      zen_usecase.center()
    end
  end,

  area = function()
    return function()
      zen_usecase.area()
    end
  end,
}

return make_controller_logged("zen", M)
