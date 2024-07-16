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
	local request = vim.fn.input("Chatbot: ")

	vim.cmd(":Chat " .. request)
end

return M
