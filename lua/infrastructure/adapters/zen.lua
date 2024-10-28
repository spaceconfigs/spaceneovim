local M = {}

local make_logged = require("application.helpers.make_logged")
local plugins = require("infrastructure.plugins.zen")

M.toggle = function()
	plugins.twilight.toggle()
end

M.center = function()
	plugins.zen_mode.toggle()
end

M.area = function()
	local first = vim.fn.line("v")
	local last = vim.fn.line(".")
	plugins.true_zen.narrow(first, last)
end

return make_logged("adapters/zen", M)
