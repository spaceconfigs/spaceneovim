---@type PomodoroUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
	setup = function()
		return require("application.ports.adapter_registry").pomodoro()
	end,

	start = function()
		local adapter = M.setup()

		adapter.start()
	end,

	status = function()
		local adapter = M.setup()

		local timer = adapter.status()
		if timer == nil then
			return ""
		end

		return "󰄉 " .. adapter.status()
	end,
}

return make_logged("usecases/pomodoro", M)
