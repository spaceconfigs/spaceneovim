local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.plugin_registry").documentation()

---@type DocumentationPort
local M = {
	open = function()
	  plugin.ui.documentations.show()
	end,
	install = function()
	  plugin.ui.documentations.install()
	end,
	remove = function()
	  plugin.ui.documentations.delete()
	end,
}

return make_logged("adapters/documentation", M)
