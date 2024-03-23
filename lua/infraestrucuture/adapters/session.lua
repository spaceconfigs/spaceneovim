local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.neovim-session-manager")

M.list = function()
	local message = {
		module = "adapters/session",
		func = "list",
	}
	logger_use_manage.debug(message)

	plugin.load_session()
end

M.save = function()
	local message = {
		module = "adapters/session",
		func = "save",
	}
	logger_use_manage.debug(message)

	plugin.save_current_session()
end

M.delete = function()
	local message = {
		module = "adapters/session",
		func = "delete",
	}
	logger_use_manage.debug(message)

	plugin.delete_session()
end

return M
