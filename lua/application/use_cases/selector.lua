local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infraestrucuture.adapters.selector")
end

M.quit = function()
	local message = {
		module = "use_cases/selector",
		func = "quit",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.quit()
end

M.all_selected = function()
	local message = {
		module = "use_cases/selector",
		func = "all_selected",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.all_selected()
end

return M
