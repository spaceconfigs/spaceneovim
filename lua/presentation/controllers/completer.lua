local make_controller_logged = require("application.helpers.make_controller_logged")
local completer_usecase = require("application.ports.use_case_registry").completer()

---@type CompleterContract
local M = {
	complete = function()
		return function()
			completer_usecase.complete()
		end
	end,
}

return make_controller_logged("completer", M)
