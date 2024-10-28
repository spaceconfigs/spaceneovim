local make_controller_logged = require("application.helpers.make_controller_logged")
local database_use_case = require("application.ports.use_case_registry").database()

---@type DatabaseContract
local M = {
	open = function()
		return function()
			database_use_case.open()
		end
	end,
}

return make_controller_logged("database", M)
