local M = {}

local logger_use_manage = require("application.use_cases.logger")
local nvim_tree = require("infraestrucuture.plugins.nvim-tree")

M.open = function()
	local message = {
		module = "adapters/todo",
		func = "open",
	}
	logger_use_manage.debug(message)

	nvim_tree.open()
end

M.close = function()
	local message = {
		module = "adapters/todo",
		func = "close",
	}
	logger_use_manage.debug(message)

	nvim_tree.close()
end

M.toggle = function()
	local message = {
		module = "adapters/todo",
		func = "toggle",
	}
	logger_use_manage.debug(message)

	nvim_tree.toggle()
end

return M
