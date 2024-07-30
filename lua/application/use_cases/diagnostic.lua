local M = {}

local logger_use_case = require("application.use_cases.logger")
local adapter = require("infraestrucuture.adapters.diagnostic")

M.setup = function()
	return require("infraestrucuture.adapters.diagnostic")
end

M.toggle = function()
	local message = {
		module = "use_cases/diagnostic",
		func = "toggle",
	}
	logger_use_case.debug(message)
	M.setup()

	adapter.toggle()
end
return M
