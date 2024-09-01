local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infraestrucuture.adapters.diagnostic")
end

M.toggle = function()
	local message = {
		module = "use_cases/diagnostic",
		func = "toggle",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.toggle()
end

M.show = function(direction)
	return function()
		local message = {
			module = "use_cases/diagnostic",
			func = "show",
			direction = direction,
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.show(direction)
	end
end

return M
