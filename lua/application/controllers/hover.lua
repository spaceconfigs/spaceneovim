local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local hover_use_case = require("application.use_cases.hover")

M.toggle = function()
	return function()
		hover_use_case.toggle()
	end
end

M.dismiss = function()
	return function()
		hover_use_case.dismiss()
	end
end

return make_controller_logged("hover", M)
