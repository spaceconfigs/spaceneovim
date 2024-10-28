local vim = vim
local lazy = require("infrastructure.plugins.lazy")

---@type PackagerPort
local M = {
	install = function()
		lazy.install()
	end,
	update = function()
		lazy.update()
	end,
}

return M
