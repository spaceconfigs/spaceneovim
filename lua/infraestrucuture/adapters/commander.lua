local M = {}

local logger_use_manage = require("application.use_cases.logger")
local telescope = require("infraestrucuture.plugins.file")

M.find = function(opts)
	local message = {
		module = "adapters/commenter",
		func = "toggle",
		opts = opts,
	}
	logger_use_manage.debug(message)

	local mode = opts and opts.mode or nil
	telescope.builtin.commands()
end

return M
