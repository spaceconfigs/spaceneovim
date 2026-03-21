local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infrastructure.adapters.quit")
end

M.all = function()
	return function()
		local message = {
			module = "use_cases/quit",
			func = "all",
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.all()
	end
end

M.save_all = function()
	return function()
		local message = {
			module = "use_cases/quit",
			func = "save_all",
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.save_all()
	end
end

return M
