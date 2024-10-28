local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.documentation")

---@type DocumentationAdapter
local M = {
	open = function()
	  plugin.ui.documentations.show()
	end,
	install = function()
	  plugin.ui.documentations.install()
	end,
}

return make_logged("adapters/documentation", M)
