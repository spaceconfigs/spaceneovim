local make_controller_logged = require("application.helpers.make_controller_logged")
local terminal_usecase = require("application.ports.usecase_registry").terminal()

---@type TerminalContract
local M = {
	toggle = function(options)
		return function()
			terminal_usecase.toggle(options)
		end
	end,
}

return make_controller_logged("terminal", M)
