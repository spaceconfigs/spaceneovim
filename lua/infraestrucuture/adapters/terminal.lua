local vim = vim
local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.terminal")

M.open = function()
	local message = {
		module = "adapters/terminal",
		func = "open",
	}
	logger_use_manage.debug(message)

	plugin:open()
end

M.close = function()
	local message = {
		module = "adapters/terminal",
		func = "close",
	}
	logger_use_manage.debug(message)

	plugin:close()
end

M.toggle = function()
	local message = {
		module = "adapters/terminal",
		func = "toggle",
	}
	logger_use_manage.debug(message)

	plugin:new():toggle()
end

M.toggle_buffer_dir = function()
	local message = {
		module = "adapters/terminal",
		func = "toggle_buffer_dir",
	}
	logger_use_manage.debug(message)
	local buffer = vim.fn.expand("%:p:h")

	plugin:new({ dir = buffer }):toggle()
end

return M
