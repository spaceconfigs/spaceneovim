local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infraestrucuture.adapters.fold")
end

M.open = function(opts)
	return function()
		opts = opts or {}
		opts.location = opts.location or "cursor"

		local message = {
			module = "use_cases/fold",
			func = "open",
			opts = opts,
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.open(opts)
	end
end

M.close = function(opts)
	return function()
		opts = opts or {}
		opts.location = opts.location or "cursor"

		local message = {
			module = "use_cases/fold",
			func = "close",
			opts = opts,
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.close(opts)
	end
end

M.toggle = function(opts)
	return function()
		opts = opts or {}
		opts.location = opts.location or "cursor"

		local message = {
			module = "use_cases/fold",
			func = "toggle",
			opts = opts,
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.toggle(opts)
	end
end
return M
