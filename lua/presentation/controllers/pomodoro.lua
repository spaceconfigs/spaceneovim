local make_controller_logged = require("application.helpers.make_controller_logged")
local pomodoro_usecase = require("application.ports.usecase_registry").pomodoro()

---@type PomodoroContract
local M = {
	start = function()
		return function()
			pomodoro_usecase.start()
		end
	end,

	status = function()
		return function()
			pomodoro_usecase.status()
		end
	end,
}

return make_controller_logged("pomodoro", M)
