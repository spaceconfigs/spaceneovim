local M = {}

local logger_use_manage = require("application.use_cases.logger")

local require_plugin = function()
	return require("infraestrucuture.plugins.window")
end

M.toggle = function()
	local message = {
		module = "adapters/window",
		func = "toggle",
	}
	logger_use_manage.debug(message)
	local plugin = require_plugin()
	plugin.toggle()
end

M.move_far_left = function()
	vim.cmd("WinShift far_left")
end

M.move_far_right = function()
	vim.cmd("WinShift far_right")
end

M.move_far_up = function()
	vim.cmd("WinShift far_up")
end

M.move_far_down = function()
	vim.cmd("WinShift far_down")
end

return M
