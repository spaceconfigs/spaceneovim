local vim = vim
local M = {}

local make_logged = require("application.helpers.make_logged")
require("infrastructure.plugins.database")

M.open = function()
	vim.cmd("DBUI")
end

return make_logged("adapters/database", M)
