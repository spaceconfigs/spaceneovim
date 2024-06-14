local M = {}

local logger_use_case = require("application.use_cases.logger")
local adapter = require("infraestrucuture.adapters.selector")

M.quit = function()
	local message = {
		module = "use_cases/selector",
		func = "quit",
	}
	logger_use_case.debug(message)

	adapter.quit()
end

M.all_selected = function()
	local message = {
		module = "use_cases/selector",
		func = "all_selected",
	}
	logger_use_case.debug(message)

	adapter.all_selected()
end

return M
