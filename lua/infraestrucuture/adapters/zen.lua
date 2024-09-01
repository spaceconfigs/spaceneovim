local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugins = require("infraestrucuture.plugins.zen")

M.toggle = function()
	local message = {
		module = "adapters/zen",
		func = "toggle",
	}
	logger_use_manage.debug(message)

	plugins.twilight.toggle()
end

M.center = function()
	local message = {
		module = "adapters/zen",
		func = "center",
	}
	logger_use_manage.debug(message)

	plugins.zen_mode.toggle()
end

M.area = function()
	local message = {
		module = "adapters/zen",
		func = "area",
	}
	logger_use_manage.debug(message)

	local first = vim.fn.line("v")
	local last = vim.fn.line(".")
	plugins.true_zen.narrow(first, last)
end

return M
