local M = {}

local logger_use_case = require("application.use_cases.logger")
local adapter = require("infraestrucuture.adapters.rest")

M.toggle = function()
	local message = {
		module = "use_cases/workspace",
		func = "add",
	}
	logger_use_case.debug(message)

	adapter.toggle()
end
return M
