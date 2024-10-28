local M = {}

local make_logged = require("application.helpers.make_logged")
local plugins = require("infrastructure.plugins.pomodoro")
local pomo = plugins.pomo

M.start = function()
	vim.cmd("TimerSession pomodoro")
end

M.status = function()
	local timer = pomo.get_first_to_finish()
	return tostring(timer)
end

return make_logged("adapters/pomodoro", M)
