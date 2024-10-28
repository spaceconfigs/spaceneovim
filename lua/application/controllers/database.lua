local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local database_use_case = require("application.use_cases.database")

M.open = function()
	return function()
		database_use_case.open()
	end
end

return make_controller_logged("database", M)
