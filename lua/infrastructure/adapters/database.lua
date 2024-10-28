local vim = vim

local make_logged = require("application.helpers.make_logged")
require("infrastructure.plugins.registry").database()

---@type DatabasePort
local M = {
	open = function()
		vim.cmd("DBUI")
	end,
}

return make_logged("adapters/database", M)
