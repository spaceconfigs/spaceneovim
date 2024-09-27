local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugins = require("infraestrucuture.plugins.pomodoro")
local pomo = plugins.pomo

M.start = function()
	local message = {
		module = "adapters/pomodoro",
		func = "start",
	}
	logger_use_manage.debug(message)

	vim.cmd("TimerSession pomodoro")
end

M.status = function()
	local message = {
		module = "adapters/pomodoro",
		func = "status",
	}
	logger_use_manage.debug(message)

	local timer = pomo.get_first_to_finish()
	return tostring(timer)
end

return M
