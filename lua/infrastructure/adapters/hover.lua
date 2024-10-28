local M = {}

local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.hover")

M.toggle = function()
	-- plugin.hover()
	vim.lsp.buf.hover()
end

return make_logged("adapters/hover", M)
