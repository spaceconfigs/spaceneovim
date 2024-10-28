local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local diagnostic_use_case = require("application.use_cases.diagnostic")

M.toggle = function()
	return function()
		diagnostic_use_case.toggle()
	end
end

M.show = function(direction)
	return function()
		diagnostic_use_case.show(direction)
	end
end

M.loclist = function()
	return function()
		diagnostic_use_case.loclist()
	end
end

return make_controller_logged("diagnostic", M)
