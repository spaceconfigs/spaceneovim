local M = {}

local logger_use_case = require("application.use_cases.logger")
local adapter = require("infraestrucuture.adapters.commander")

M.find = function()
	local message = {
		module = "use_cases/commenter",
		func = "toggle_current_line",
	}
	logger_use_case.debug(message)

	adapter.find()
end

return M
