local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local zen_use_case = require("application.use_cases.zen")

M.toggle = function()
  return function()
    zen_use_case.toggle()
  end
end

M.center = function()
  return function()
    zen_use_case.center()
  end
end

M.area = function()
  return function()
    zen_use_case.area()
  end
end

return make_controller_logged("zen", M)
