local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infraestrucuture.adapters.chatbot")
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

return M
