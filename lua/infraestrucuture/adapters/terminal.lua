local vim = vim
local M = {}

local logger_use_manage = require("application.use_cases.logger")

local setup = function()
	return require("infraestrucuture.plugins.terminal")
end

M.open = function()
	local message = {
		module = "adapters/terminal",
		func = "open",
	}
	logger_use_manage.debug(message)
	local plugin = setup()
	plugin:open()
end

M.close = function()
	local message = {
		module = "adapters/terminal",
		func = "close",
	}
	logger_use_manage.debug(message)
	local plugin = setup()

	plugin:close()
end

M.toggle = function()
	local message = {
		module = "adapters/terminal",
		func = "toggle",
	}
	logger_use_manage.debug(message)
	local plugin = setup()

	plugin:new():toggle()
end

M.toggle_buffer_dir = function()
	local message = {
		module = "adapters/terminal",
		func = "toggle_buffer_dir",
	}
	logger_use_manage.debug(message)
	local plugin = setup()
	local buffer = vim.fn.expand("%:p:h")

	plugin:new({ dir = buffer }):toggle()
end

return M
