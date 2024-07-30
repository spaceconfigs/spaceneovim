local M = {}

local logger_use_case = require("application.use_cases.logger")
local adapter = require("infraestrucuture.adapters.hover")

M.setup = function()
	return require("infraestrucuture.adapters.hover")
end

M.toggle = function()
	local message = {
		module = "use_cases/hover",
		func = "toggle",
	}
	logger_use_case.debug(message)
	M.setup()

	adapter.toggle()
end
return M
