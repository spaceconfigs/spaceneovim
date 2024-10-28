local make_logged = require("application.helpers.make_logged")
require("infrastructure.plugins.selector")

---@type SelectorAdapter
local M = {
	all_selected = function()
		vim.cmd("MCstart")
	end,

	quit = function()
		vim.cmd("MCclear")
	end,
}

return make_logged("adapters/selector", M)
