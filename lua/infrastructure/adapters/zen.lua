local make_logged = require("application.helpers.make_logged")
local plugins = require("infrastructure.plugins.zen")

---@type ZenPort
local M = {
	toggle = function()
		plugins.twilight.toggle()
	end,

	center = function()
		plugins.zen_mode.toggle()
	end,

	area = function()
		local first = vim.fn.line("v")
		local last = vim.fn.line(".")
		plugins.true_zen.narrow(first, last)
	end,
}

return make_logged("adapters/zen", M)
