local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.commenter")

M.toggle = function(opts)
	local message = {
		module = "adapters/commenter",
		func = "toggle",
		opts = opts,
	}
	logger_use_manage.debug(message)

	local mode = opts and opts.mode or nil
	plugin.api.toggle.linewise(mode)
end

return M
