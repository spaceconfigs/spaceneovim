local make_controller_logged = require("application.helpers.make_controller_logged")
local database_usecase = require("application.ports.use_case_registry").database()

---@type DatabaseContract
local M = {
	open = function()
		return function()
			database_usecase.open()
		end
	end,
}

return make_controller_logged("database", M)
