local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local rest_use_case = require("application.use_cases.rest")

M.open = function()
  return function()
    rest_use_case.open()
  end
end

M.send = function()
  return function()
    rest_use_case.send()
  end
end

M.replay = function()
  return function()
    rest_use_case.replay()
  end
end

return make_controller_logged("rest", M)
