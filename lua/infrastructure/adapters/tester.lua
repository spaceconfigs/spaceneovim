local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.registry").tester()
local neotest = plugin.neotest

---@type TesterPort
local M = {
	toggle = function()
		neotest.summary.toggle()
	end,

	run = function()
		neotest.run.run(vim.fn.expand("%"))
	end,
}

return make_logged("adapters/tester", M)
