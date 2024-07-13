local M = {}

local logger_use_manage = require("application.use_cases.logger")

local setup = function()
	return require("infraestrucuture.plugins.layout")
end

M.list = function()
	local message = {
		module = "adapters/layout",
		func = "list",
	}
	logger_use_manage.debug(message)
	local plugin = setup()

	plugin.load_session()
end

M.save = function()
	local message = {
		module = "adapters/layout",
		func = "save",
	}
	logger_use_manage.debug(message)
	local plugin = setup()

	plugin.save_current_session()
end

M.reload = function()
	local message = {
		module = "adapters/layout",
		func = "reload",
	}
	logger_use_manage.debug(message)
	local plugin = setup()

	plugin.load_current_dir_session()
end

M.delete = function()
	local message = {
		module = "adapters/layout",
		func = "delete",
	}
	logger_use_manage.debug(message)
	local plugin = setup()

	plugin.delete_session()
end

return M
