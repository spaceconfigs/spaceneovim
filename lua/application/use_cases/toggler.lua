local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infrastructure.adapters.toggler")
end

M.number = function()
	return function()
		local message = {
			module = "use_cases/toggler",
			func = "number",
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.number()
	end
end

M.wrap = function()
	return function()
		local message = {
			module = "use_cases/toggler",
			func = "wrap",
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.wrap()
	end
end

return M
