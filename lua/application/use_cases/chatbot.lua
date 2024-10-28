local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infrastructure.adapters.chatbot")
end

M.toggle = function(opts)
	return function()
		opts = opts or {}
		opts.provider = opts.provider or "avante"

		local message = {
			module = "use_cases/ai",
			func = "toggle",
			opts = opts,
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.toggle(opts)
	end
end

M.edit = function(opts)
	return function()
		opts = opts or {}
		opts.provider = opts.provider or "claudecode"

		local message = {
			module = "use_cases/ai",
			func = "edit",
			opts = opts,
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.edit(opts)
	end
end

M.zenmode = function(opts)
	return function()
		opts = opts or {}
		opts.action = opts.action or "toggle"

		local message = {
			module = "use_cases/ai",
			func = "zenmode",
			opts = opts,
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.zenmode(opts)
	end
end

M.session = function(opts)
	return function()
		opts = opts or {}
		opts.action = opts.action or "toggle"
		opts.provider = opts.provider or "claudecode"

		local message = {
			module = "use_cases/ai",
			func = "session",
			opts = opts,
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.session(opts)
	end
end

M.send_prompt = function()
	return function()
		local message = {
			module = "use_cases/chatbot",
			func = "send_prompt",
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.send_prompt()
	end
end

M.add_file = function()
	return function()
		local message = {
			module = "use_cases/chatbot",
			func = "add_file",
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.add_file()
	end
end

M.select_model = function()
	return function()
		local message = {
			module = "use_cases/chatbot",
			func = "select_model",
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.select_model()
	end
end

M.accept_diff = function()
	return function()
		local message = {
			module = "use_cases/chatbot",
			func = "accept_diff",
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.accept_diff()
	end
end

M.deny_diff = function()
	return function()
		local message = {
			module = "use_cases/chatbot",
			func = "deny_diff",
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.deny_diff()
	end
end

return M
