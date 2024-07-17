local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.layout")
print(vim.inspect(plugin))

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

M.reload = function()
	local message = {
		module = "adapters/layout",
		func = "reload",
	}
	logger_use_manage.debug(message)

	plugin.load_current_dir_session()
end

M.delete = function()
	local message = {
		module = "adapters/layout",
		func = "delete",
	}
	logger_use_manage.debug(message)

	plugin.delete_session()
end

M.previous = function()
	local message = {
		module = "adapters/layout",
		func = "previous",
	}
	logger_use_manage.debug(message)

	plugin.load_last_session()
end

M.rename = function()
	local message = {
		module = "adapters/layout",
		func = "rename",
	}
	logger_use_manage.debug(message)

	vim.fn.input("Rename: ")
end
return M
