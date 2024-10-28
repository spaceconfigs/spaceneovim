local M = {}

local adapter = require("infrastructure.adapters.hover")

M.setup = function()
	return require("infrastructure.adapters.hover")
end

M.toggle = function()
	M.setup()

	adapter.toggle()
end
return M
