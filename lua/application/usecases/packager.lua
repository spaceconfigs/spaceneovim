---@type PackagerUseCase
local M

local adapter = require("application.ports.adapter_registry").packager()

M = {
	install = function()
		adapter.install()
	end,

	update = function()
		adapter.update()
	end,
}

return M
