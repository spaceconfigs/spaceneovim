local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infrastructure.adapters.documentation")
end

M.open = function()
	local message = {
		module = "use_cases/documentation",
		func = "open",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.open()
end

M.install = function()
	local message = {
		module = "use_cases/documentation",
		func = "open",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.install()
end

return M
