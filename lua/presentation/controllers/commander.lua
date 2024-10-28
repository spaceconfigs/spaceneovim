local make_controller_logged = require("application.helpers.make_controller_logged")
local commander_use_case = require("application.ports.use_case_registry").commander()

---@type CommanderContract
local M = {
	find = function()
		return function()
			commander_use_case.find()
		end
	end,
}

return make_controller_logged("commander", M)
