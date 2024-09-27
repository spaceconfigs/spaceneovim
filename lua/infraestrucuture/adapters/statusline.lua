local M = {}

local logger_use_manage = require("application.use_cases.logger")
local statusline = require("infraestrucuture.plugins.statusline")

local is_open = false

M.toggle = function()
	local message = {
		module = "adapters/statusline",
		func = "toggle",
	}
	logger_use_manage.debug(message)

	if is_open then
		is_open = false
	else
		is_open = true
	end

	statusline.hide({
		place = { "statusline" }, -- The segment this change applies to.
		unhide = is_open,
	})
end

return M
