local make_controller_logged = require("application.helpers.make_controller_logged")
local terminal_use_case = require("application.use_cases.terminal")

---@type TerminalContract
local M = {
	toggle = function(options)
		return function()
			terminal_use_case.toggle(options)
		end
	end,
}

return make_controller_logged("terminal", M)
