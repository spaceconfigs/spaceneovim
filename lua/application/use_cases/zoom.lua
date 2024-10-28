local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infrastructure.adapters.zoom")
end

M.change = function(opts)
	return function()
		opts = opts or {}
		opts.delta = opts.delta or 1

		local message = {
			module = "use_cases/zoom",
			func = "toggle",
			opts = opts,
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.change(opts)
	end
end

return M
