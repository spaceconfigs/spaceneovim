local M = {}

local logger_use_manage = require("application.use_cases.logger")

local setup = function()
	return require("infraestrucuture.plugins.commenter")
end

M.toggle = function(opts)
	local message = {
		module = "adapters/commenter",
		func = "toggle",
		opts = opts,
	}
	logger_use_manage.debug(message)
	local plugin = setup()

	local mode = opts and opts.mode or nil
	plugin.api.toggle.linewise(mode)
end

return M
