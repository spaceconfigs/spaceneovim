local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local formatter_use_case = require("application.use_cases.formatter")

M.format = function()
  return function()
    formatter_use_case.format()
  end
end

return make_controller_logged("formatter", M)
