local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.window")
local maximize = plugin.maximize
local zen_mode = plugin.zen_mode

M.toggle = function()
	local message = {
		module = "adapters/window",
		func = "toggle",
	}
	logger_use_manage.debug(message)

	maximize.toggle()
end

M.go_right = function()
	local message = {
		module = "adapters/window",
		func = "got_right",
	}
	logger_use_manage.debug(message)

	vim.cmd("wincmd l")
end

M.go_left = function()
	local message = {
		module = "adapters/window",
		func = "go_left",
	}
	logger_use_manage.debug(message)

	vim.cmd("wincmd h")
end

M.go_up = function()
	local message = {
		module = "adapters/window",
		func = "go_up",
	}
	logger_use_manage.debug(message)

	vim.cmd("wincmd k")
end

M.go_down = function()
	local message = {
		module = "adapters/window",
		func = "go_down",
	}
	logger_use_manage.debug(message)

	vim.cmd("wincmd j")
end

M.move_right = function()
	local message = {
		module = "adapters/window",
		func = "move_right",
	}
	logger_use_manage.debug(message)

	vim.cmd("WinShift right")
end

M.move_left = function()
	local message = {
		module = "adapters/window",
		func = "move_left",
	}
	logger_use_manage.debug(message)

	vim.cmd("WinShift left")
end

M.move_up = function()
	local message = {
		module = "adapters/window",
		func = "move_up",
	}
	logger_use_manage.debug(message)

	vim.cmd("WinShift up")
end

M.move_down = function()
	local message = {
		module = "adapters/window",
		func = "move_down",
	}
	logger_use_manage.debug(message)

	vim.cmd("WinShift down")
end

M.move_far_left = function()
	local message = {
		module = "adapters/window",
		func = "move_far_left",
	}
	logger_use_manage.debug(message)

	vim.cmd("WinShift far_left")
end

M.move_far_right = function()
	local message = {
		module = "adapters/window",
		func = "move_far_right",
	}
	logger_use_manage.debug(message)

	vim.cmd("WinShift far_right")
end

M.move_far_up = function()
	local message = {
		module = "adapters/window",
		func = "move_far_up",
	}
	logger_use_manage.debug(message)

	vim.cmd("WinShift far_up")
end

M.move_far_down = function()
	local message = {
		module = "adapters/window",
		func = "move_far_down",
	}
	logger_use_manage.debug(message)

	vim.cmd("WinShift far_down")
end

M.dedicate = function()
	local message = {
		module = "adapters/window",
		func = "dedicate",
	}
	logger_use_manage.debug(message)

	vim.cmd("PinBuffer")
end

M.center = function()
	local message = {
		module = "adapters/window",
		func = "center",
	}
	logger_use_manage.debug(message)

	zen_mode.toggle()
end

return M
