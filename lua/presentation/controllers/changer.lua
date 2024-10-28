local make_controller_logged = require("application.helpers.make_controller_logged")
local changer_usecase = require("application.ports.use_case_registry").changer()

---@type ChangerContract
local M = {
	list = function()
		return function()
			changer_usecase.list()
		end
	end,
}

return make_controller_logged("changer", M)
