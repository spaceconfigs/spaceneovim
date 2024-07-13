local vim = vim
local M = {}

local logger_use_manage = require("application.use_cases.logger")

local setup = function()
	return require("infraestrucuture.plugins.chatbot")
end

M.toggle = function()
	local message = {
		module = "adapters/chatbot",
		func = "toggle",
	}
	logger_use_manage.debug(message)
	setup()

	local request = vim.fn.input("Chatbot: ")
	vim.cmd(":Chat " .. request)
end

return M
