local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infraestrucuture.adapters.rest")
end

M.send = function()
	local message = {
		module = "use_cases/workspace",
		func = "add",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.send()
end

return M
