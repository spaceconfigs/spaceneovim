local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local completer_use_case = require("application.use_cases.completer")

M.complete = function()
	return function()
		completer_use_case.complete()
	end
end

return make_controller_logged("completer", M)
