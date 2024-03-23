local M = {}

local logger_use_manage = require("application.use_cases.logger")
local devdocs = require("infraestrucuture.plugins.nvim-devdocs")

M.open = function()
	local message = {
		module = "adapters/documentation",
		func = "open",
	}
	logger_use_manage.debug(message)

	devdocs.open()
end

return M
