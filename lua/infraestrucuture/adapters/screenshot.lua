local M = {}

local logger_use_manage = require("application.use_cases.logger")

local setup = function()
	return require("infraestrucuture.plugins.screenshot")
end

M.copy = function()
	local message = {
		module = "adapters/screenshot",
		func = "copy",
	}
	logger_use_manage.debug(message)
	local plugin = setup()

	plugin.copy_into_clipboard()
end

M.save = function()
	local message = {
		module = "adapters/screenshot",
		func = "save",
	}
	logger_use_manage.debug(message)
	local plugin = setup()

	plugin.save_snapshot()
end
return M
