local vim = vim
local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.chatbot")

M.toggle = function()
	local message = {
		module = "adapters/chatbot",
		func = "toggle",
	}
	logger_use_manage.debug(message)

	vim.cmd("AvanteAsk")
end

M.edit = function()
	local message = {
		module = "adapters/chatbot",
		func = "edit",
	}
	logger_use_manage.debug(message)

	vim.cmd("AvanteEdit")
end

return M
