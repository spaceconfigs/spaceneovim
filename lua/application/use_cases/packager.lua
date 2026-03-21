local M = {}

local adapter = require("infrastructure.adapters.packager")

M.install = function()
	adapter.install()
end

M.update = function()
	adapter.update()
end

return M
