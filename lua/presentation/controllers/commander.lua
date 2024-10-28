local make_controller_logged = require("application.helpers.make_controller_logged")
local commander_usecase = require("application.ports.usecase_registry").commander()

---@type CommanderContract
local M = {
	find = function()
		return function()
			commander_usecase.find()
		end
	end,
}

return make_controller_logged("commander", M)
