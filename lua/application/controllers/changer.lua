local make_controller_logged = require("application.helpers.make_controller_logged")
local changer_use_case = require("application.use_cases.changer")

---@type ChangerContract
local M = {
	list = function()
		return function()
			changer_use_case.list()
		end
	end,
}

return make_controller_logged("changer", M)
