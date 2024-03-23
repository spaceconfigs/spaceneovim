local M = {}

local logger_use_case = require("application.use_cases.logger")
local adapter = require("infraestrucuture.adapters.tree")

M.open = function()
	local message = {
		module = "use_cases/tree",
		func = "open",
	}
	logger_use_case.debug(message)

	adapter.open()
end

M.close = function()
	local message = {
		module = "use_cases/tree",
		func = "close",
	}
	logger_use_case.debug(message)
	adapter.close()
end

M.toggle = function()
	local message = {
		module = "use_cases/tree",
		func = "toggle",
	}
	logger_use_case.debug(message)

	adapter.toggle()
end

return M
