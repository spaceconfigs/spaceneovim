local M = {}

local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.formatter")

M.format = function()
	plugin.format({
		lsp_fallback = true,
		async = true,
	})
end

return make_logged("adapters/formatter", M)
