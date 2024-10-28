local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local tester_use_case = require("application.use_cases.tester")

M.toggle = function(opts)
	return function()
		tester_use_case.toggle(opts)
	end
end

M.run = function(opts)
	return function()
		tester_use_case.run(opts)
	end
end

return make_controller_logged("tester", M)
