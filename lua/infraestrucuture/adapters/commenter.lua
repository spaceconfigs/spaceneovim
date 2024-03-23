local M = {}

local logger_use_manage = require("application.use_cases.logger")
local comment = require("infraestrucuture.plugins.Comment")

M.toggle = function(opts)
	local message = {
		module = "adapters/commenter",
		func = "toggle",
		opts = opts,
	}
	logger_use_manage.debug(message)

	local mode = opts and opts.mode or nil
	comment.api.toggle.linewise(mode)
end

return M
