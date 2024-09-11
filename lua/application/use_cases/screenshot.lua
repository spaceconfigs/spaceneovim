local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infraestrucuture.adapters.screenshot")
end

M.copy = function(options)
	return function()
		local message = {
			module = "use_cases/screenshot",
			func = "copy",
			options = options,
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		options = options or {}
		options.type = options.type or ""

		adapter.copy(options)
	end
end

M.save = function()
	local message = {
		module = "use_cases/screenshot",
		func = "save",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.save()
end

return M
