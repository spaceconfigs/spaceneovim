local M = {}

local logger_use_manage = require("application.use_cases.logger")

local require_plugin = function()
	return require("infraestrucuture.plugins.file")
end

M.find = function(opts)
	local message = {
		module = "adapters/commenter",
		func = "toggle",
		opts = opts,
	}
	logger_use_manage.debug(message)
	local file = require_plugin()

	file.builtin.commands()
end

return M
