local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infraestrucuture.adapters.commander")
end

M.find = function()
	local message = {
		module = "use_cases/commenter",
		func = "toggle_current_line",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.find()
end

return M
