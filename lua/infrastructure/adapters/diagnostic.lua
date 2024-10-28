local M = {}

local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.diagnostic")
local snacks = plugin.snacks
local lint = plugin.lint

M.toggle = function()
	snacks.picker.diagnostics_buffer()
end

M.show = function(direction)
	if direction == "previous" then
		return vim.diagnostic.jump({ count = -1 })
	end

	if direction == "next" then
		return vim.diagnostic.jump({ count = 1 })
	end

  vim.diagnostic.open_float()
end

M.loclist = function()
	vim.diagnostic.setloclist()
end

M.lint = function()
	lint.try_lint()
end

return make_logged("adapters/diagnostic", M)
