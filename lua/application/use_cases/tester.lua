local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infraestrucuture.adapters.tester")
end

M.toggle = function(opts)
	return function()
		local message = {
			module = "use_cases/tester",
			func = "toggle",
			opts = opts,
		}
		opts = opts or {}

		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.toggle()
	end
end

M.run = function(opts)
	return function()
		local message = {
			module = "use_cases/tester",
			func = "run",
			opts = opts,
		}
		opts = opts or {}

		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.run()
	end
end

return M
