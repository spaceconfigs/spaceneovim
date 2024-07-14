local M = {}

local logger_use_manage = require("application.use_cases.logger")

M.setup = function()
	return require("infraestrucuture.plugins.completer")
end

M.complete = function()
	local message = {
		module = "adapters/completer",
		func = "complete",
	}
	logger_use_manage.debug(message)
	local plugin = M.setup()

	if plugin.visible() then
		plugin.abort()
	end

	plugin.complete()
end

return M
