local M = {}

local logger_use_manage = require("application.use_cases.logger")

local setup = function()
	return require("infraestrucuture.plugins.formatter")
end

M.format = function()
	local message = {
		module = "adapters/formatter",
		func = "format",
	}
	logger_use_manage.debug(message)
	local plugin = setup()

	plugin.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	})
end

return M
