local M = {}

local logger_use_manage = require("application.use_cases.logger")

local setup = function()
	return require("infraestrucuture.plugins.tree")
end

M.open = function()
	local message = {
		module = "adapters/todo",
		func = "open",
	}
	logger_use_manage.debug(message)
	local plugin = setup().nvim_tree

	plugin.open()
end

M.close = function()
	local message = {
		module = "adapters/todo",
		func = "close",
	}
	logger_use_manage.debug(message)
	local plugin = setup().nvim_tree

	plugin.close()
end

M.toggle = function(opts)
	local message = {
		module = "adapters/todo",
		func = "toggle",
		opts = opts,
	}
	logger_use_manage.debug(message)
	local plugin = setup().oil

	plugin.toggle_float(opts.location)
	-- nvim_tree.toggle()
end

return M
