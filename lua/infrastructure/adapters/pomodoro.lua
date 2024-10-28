local make_logged = require("application.helpers.make_logged")
local plugins = require("infrastructure.plugins.registry").pomodoro()
local pomo = plugins.pomo

---@type PomodoroPort
local M = {
	start = function()
		vim.cmd("TimerSession pomodoro")
	end,
	status = function()
		local timer = pomo.get_first_to_finish()
		return tostring(timer)
	end,
}

return make_logged("adapters/pomodoro", M)
