local make_controller_logged = require("application.helpers.make_controller_logged")
local pomodoro_use_case = require("application.use_cases.pomodoro")

---@type PomodoroContract
local M = {
	start = function()
		return function()
			pomodoro_use_case.start()
		end
	end,

	status = function()
		return function()
			pomodoro_use_case.status()
		end
	end,
}

return make_controller_logged("pomodoro", M)
