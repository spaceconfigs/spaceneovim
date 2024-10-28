local M = {}

local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.tester")
local neotest = plugin.neotest

M.toggle = function()
	neotest.summary.toggle()
end

M.run = function()
	neotest.run.run(vim.fn.expand("%"))
end

return make_logged("adapters/tester", M)
