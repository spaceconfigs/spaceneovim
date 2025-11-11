local vim = vim
local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.chatbot")
local opencode = plugin.opencode
local mcphub = plugin.mcphub

M.toggle = function(opts)
	opts = opts or {}
	opts.provider = opts.provider or "claudecode"

	local message = {
		module = "adapters/chatbot",
		func = "toggle",
		opts = opts,
	}
	logger_use_manage.debug(message)

	if opts.provider == "claudecode" then
		vim.cmd("ClaudeCode")
	elseif opts.provider == "opencode" then
		opencode.toggle()
	end
end

M.session = function(opts)
	opts = opts or {}
	opts.provider = opts.provider or "claudecode"

	local message = {
		module = "adapters/chatbot",
		func = "session",
		opts = opts,
	}
	logger_use_manage.debug(message)

	local mapper = {
		start = "ClaudeCodeStart",
		continue = "ClaudeCode --continue",
		resume = "ClaudeCode --resume",
		list = "ClaudeCode --resume",
		buffer = "ClaudeCodeFocus",
		toggle = "ClaudeCode",
		stop = "ClaudeCodeStop",
	}

	if opts.provider == "opencode" then
		mapper = {
			start = function()
				opencode.command("session_new")
			end,
			continue = function()
				opencode.toggle()
			end,
			resume = function()
				opencode.toggle()
			end,
			list = function()
				opencode.select()
			end,
			buffer = function()
				opencode.toggle()
			end,
			toggle = function()
				opencode.toggle()
			end,
			stop = function()
				opencode.command("session_interrupt")
			end,
		}
	end

	local action = mapper[opts.action]
	if type(action) == "function" then
		action()
	else
		vim.cmd(action)
	end
end

M.edit = function(opts)
	opts = opts or {}
	opts.provider = opts.provider or "claudecode"

	local message = {
		module = "adapters/chatbot",
		func = "edit",
		opts = opts,
	}
	logger_use_manage.debug(message)

	if opts.provider == "claudecode" then
		vim.cmd("ClaudeCodeSend")
	elseif opts.provider == "opencode" then
		opencode.ask("@this: ", { submit = true })
	end
end

M.zenmode = function(opts)
	local message = {
		module = "adapters/chatbot",
		func = "zenmode",
		opts = opts,
	}
	logger_use_manage.debug(message)
	local mapper = {
		toggle = "ClaudeCode",
		start = "ClaudeCode",
		continue = "ClaudeCodeContinue",
		resume = "ClaudeCodeResume",
	}

	local cmd = mapper[opts.action]
	vim.cmd(cmd)
end

return M
