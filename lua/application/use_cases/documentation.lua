local M = {}

local logger_use_case = require("application.use_cases.logger")
local adapter = require("infraestrucuture.adapters.documentation")

M.open = function()
	local message = {
		module = "use_cases/documentation",
		func = "open",
	}
	logger_use_case.debug(message)

	adapter.open()
end

return M
