local M = {}

M.setup = function()
	return require("infrastructure.adapters.pomodoro")
end

M.start = function()
	local adapter = M.setup()

	adapter.start()
end

M.status = function()
	local adapter = M.setup()

	local timer = adapter.status()
	if timer == nil then
		return ""
	end

	return "󰄉 " .. adapter.status()
end

return M
