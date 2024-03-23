local M = {}

local logger_use_case = require("application.use_cases.logger")
local adapter = require("infraestrucuture.adapters.chatbot")

M.toggle = function()
	local message = {
		module = "use_cases/ai",
		func = "list",
	}
	logger_use_case.debug(message)

	adapter.toggle()
end

return M
