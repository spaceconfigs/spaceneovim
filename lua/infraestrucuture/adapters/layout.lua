local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.layout")

M.list = function()
	local message = {
		module = "adapters/layout",
		func = "list",
	}
	logger_use_manage.debug(message)

	plugin.load_session()
end

M.save = function()
	local message = {
		module = "adapters/layout",
		func = "save",
	}
	logger_use_manage.debug(message)

	plugin.save_current_session()
end

M.delete = function()
	local message = {
		module = "adapters/layout",
		func = "delete",
	}
	logger_use_manage.debug(message)

	plugin.delete_session()
end

return M
