local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.formatter")

M.format = function()
	local message = {
		module = "adapters/formatter",
		func = "format",
	}
	logger_use_manage.debug(message)

	plugin.format({
		lsp_fallback = true,
		async = true,
	})
end

return M
