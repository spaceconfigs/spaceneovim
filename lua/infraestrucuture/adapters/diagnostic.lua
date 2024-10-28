local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.diagnostic")
local file_use_manage = require("infraestrucuture.plugins.file")
local builtin = file_use_manage.telescope.builtin

M.toggle = function()
	local message = {
		module = "adapters/diagnostic",
		func = "toggle",
	}
	logger_use_manage.debug(message)

	plugin.try_lint()
	builtin.diagnostics()
end

M.show = function(direction)
	local message = {
		module = "adapters/diagnostic",
		func = "show",
		direction = direction,
	}
	logger_use_manage.debug(message)

	if direction == "previous" then
		return vim.diagnostic.goto_prev()
	end

	if direction == "next" then
		return vim.diagnostic.goto_next()
	end

	vim.diagnostic.open_float()
end

return M
