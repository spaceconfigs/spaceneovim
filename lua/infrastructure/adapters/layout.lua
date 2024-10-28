local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.plugin_registry").layout()

---@type LayoutPort
local M = {
	list = function()
		plugin.load_session()
	end,
	save = function()
		plugin.save_current_session()
	end,
	reload = function()
		plugin.load_current_dir_session()
	end,
	delete = function()
		plugin.delete_session()
	end,
	previous = function()
		plugin.load_last_session()
	end,
	rename = function()
		vim.fn.input("Rename: ")
	end,
}

return make_logged("adapters/layout", M)
