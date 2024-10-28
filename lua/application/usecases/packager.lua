local M = {}

local adapter = require("application.ports.adapter_registry").packager()

M.install = function()
	adapter.install()
end

M.update = function()
	adapter.update()
end

return M
