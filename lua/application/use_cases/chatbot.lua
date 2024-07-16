local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infraestrucuture.adapters.chatbot")
end

M.toggle = function()
	local message = {
		module = "use_cases/ai",
		func = "list",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.toggle()
end

return M
