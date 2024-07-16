local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.completer")

M.complete = function()
	local message = {
		module = "adapters/completer",
		func = "complete",
	}
	logger_use_manage.debug(message)

	if plugin.visible() then
		plugin.abort()
	end

	plugin.complete()
end

return M
