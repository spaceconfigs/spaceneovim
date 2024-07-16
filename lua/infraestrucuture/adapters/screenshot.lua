local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.screenshot")

M.copy = function()
	local message = {
		module = "adapters/screenshot",
		func = "copy",
	}
	logger_use_manage.debug(message)

	plugin.copy_into_clipboard()
end

M.save = function()
	local message = {
		module = "adapters/screenshot",
		func = "save",
	}
	logger_use_manage.debug(message)

	plugin.save_snapshot()
end
return M
