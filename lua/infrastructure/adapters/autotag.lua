local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.plugin_registry").autotag()

---@type AutotagPort
local M = {
	setup = function()
		-- The plugin's own FileType autocmd is registered too late for the
		-- buffer that triggered the load, so attach it explicitly (idempotent,
		-- no-op for filetypes without a tag config).
		plugin.internal.attach()
	end,
}

return make_logged("adapters/autotag", M)
