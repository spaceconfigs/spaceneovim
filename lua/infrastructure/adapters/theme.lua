local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.plugin_registry").theme()

---@type ThemePort
local M = {
	list = function()
		plugin.themery()
	end,

	load = function()
	end,
}

return make_logged("adapters/theme", M)
