local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugins = require("infraestrucuture.plugins.tree")
local nvim_tree = plugins.nvim_tree

M.open = function()
	local message = {
		module = "adapters/tree",
		func = "open",
	}
	logger_use_manage.debug(message)

	nvim_tree.tree.open()
end

M.close = function()
	local message = {
		module = "adapters/tree",
		func = "close",
	}
	logger_use_manage.debug(message)

	nvim_tree.tree.close()
end

M.toggle = function(opts)
	local message = {
		module = "adapters/todo",
		func = "toggle",
		opts = opts,
	}
	logger_use_manage.debug(message)

	nvim_tree.tree.toggle({ path = opts.location })
end

return M
