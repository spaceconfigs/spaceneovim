local make_controller_logged = require("application.helpers.make_controller_logged")
local formatter_use_case = require("application.ports.use_case_registry").formatter()

---@type FormatterContract
local M = {
  format = function()
    return function()
      formatter_use_case.format()
    end
  end,
}

return make_controller_logged("formatter", M)
