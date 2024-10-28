local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.plugin_registry").formatter()

---@type FormatterPort
local M = {
	format = function()
		plugin.format({
			lsp_fallback = true,
			async = true,
		})
	end,
}

return make_logged("adapters/formatter", M)
