local make_logged = require("application.helpers.make_logged")
local statusline = require("infrastructure.plugins.plugin_registry").statusline()

local is_open = false

---@type StatuslinePort
local M = {
	toggle = function()
		if is_open then
			is_open = false
		else
			is_open = true
		end

		statusline.hide({
			place = { "statusline" }, -- The segment this change applies to.
			unhide = is_open,
		})
	end,
}

return make_logged("adapters/statusline", M)
