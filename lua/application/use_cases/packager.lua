local M = {}

local adapter = require("infraestrucuture.adapters.packager")

M.install = function()
	adapter.install()
end

M.update = function()
	adapter.update()
end

return M
