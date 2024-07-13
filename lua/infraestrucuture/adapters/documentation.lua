local M = {}

local logger_use_manage = require("application.use_cases.logger")

local setup = function()
	return require("infraestrucuture.plugins.documentation")
end

M.open = function()
	local message = {
		module = "adapters/documentation",
		func = "open",
	}
	logger_use_manage.debug(message)
	local plugin = setup()

	plugin.open()
end

return M
