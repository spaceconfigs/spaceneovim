local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infrastructure.plugins.diagnostic")
local snacks = plugin.snacks

M.toggle = function()
	local message = {
		module = "adapters/diagnostic",
		func = "toggle",
	}
	logger_use_manage.debug(message)

	snacks.picker.diagnostics_buffer()
end

M.show = function(direction)
	local message = {
		module = "adapters/diagnostic",
		func = "show",
		direction = direction,
	}
	logger_use_manage.debug(message)

	if direction == "previous" then
		return vim.diagnostic.jump({ count = -1 })
	end

	if direction == "next" then
		return vim.diagnostic.jump({ count = 1 })
	end

  vim.diagnostic.open_float()
end

return M
