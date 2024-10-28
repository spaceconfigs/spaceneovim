local make_controller_logged = require("application.helpers.make_controller_logged")
local completer_use_case = require("application.ports.use_case_registry").completer()

---@type CompleterContract
local M = {
	complete = function()
		return function()
			completer_use_case.complete()
		end
	end,
}

return make_controller_logged("completer", M)
