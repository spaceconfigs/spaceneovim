local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local zoom_use_case = require("application.use_cases.zoom")

M.change = function(opts)
  return function()
    zoom_use_case.change(opts)
  end
end

return make_controller_logged("zoom", M)
