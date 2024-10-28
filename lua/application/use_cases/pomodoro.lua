local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	local message = {
		module = "use_cases/pomodoro",
		func = "setup",
	}
	logger_use_case.debug(message)

	return require("infraestrucuture.adapters.pomodoro")
end

M.start = function()
	local message = {
		module = "use_cases/pomodoro",
		func = "start",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.start()
end

M.status = function()
	local message = {
		module = "use_cases/pomodoro",
		func = "status",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	local timer = adapter.status()
	if timer == nil then
		return ""
	end

	return "󰄉 " .. adapter.status()
end

return M
