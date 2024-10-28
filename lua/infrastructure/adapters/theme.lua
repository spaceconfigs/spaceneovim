local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.theme")

---@type ThemeAdapter
local M = {
	list = function()
		plugin.themery()
	end,

	load = function()
	end,
}

return make_logged("adapters/theme", M)
