local M = {}

local logger_use_case = require("application.use_cases.logger")
local chatbot_use_case = require("application.use_cases.chatbot")

M.toggle = function(opts)
	return function()
		local message = {
			module = "controllers/chatbot",
			func = "toggle",
			opts = opts,
		}
		logger_use_case.debug(message)
		chatbot_use_case.toggle(opts)
	end
end

M.edit = function(opts)
	return function()
		local message = {
			module = "controllers/chatbot",
			func = "edit",
			opts = opts,
		}
		logger_use_case.debug(message)
		chatbot_use_case.edit(opts)
	end
end

M.zenmode = function(opts)
	return function()
		local message = {
			module = "controllers/chatbot",
			func = "zenmode",
			opts = opts,
		}
		logger_use_case.debug(message)
		chatbot_use_case.zenmode(opts)
	end
end

M.session = function(opts)
	return function()
		local message = {
			module = "controllers/chatbot",
			func = "session",
			opts = opts,
		}
		logger_use_case.debug(message)
		chatbot_use_case.session(opts)
	end
end

M.send_prompt = function()
	return function()
		local message = {
			module = "controllers/chatbot",
			func = "send_prompt",
		}
		logger_use_case.debug(message)
		chatbot_use_case.send_prompt()
	end
end

M.add_file = function()
	return function()
		local message = {
			module = "controllers/chatbot",
			func = "add_file",
		}
		logger_use_case.debug(message)
		chatbot_use_case.add_file()
	end
end

M.select_model = function()
	return function()
		local message = {
			module = "controllers/chatbot",
			func = "select_model",
		}
		logger_use_case.debug(message)
		chatbot_use_case.select_model()
	end
end

M.accept_diff = function()
	return function()
		local message = {
			module = "controllers/chatbot",
			func = "accept_diff",
		}
		logger_use_case.debug(message)
		chatbot_use_case.accept_diff()
	end
end

M.deny_diff = function()
	return function()
		local message = {
			module = "controllers/chatbot",
			func = "deny_diff",
		}
		logger_use_case.debug(message)
		chatbot_use_case.deny_diff()
	end
end

return M
