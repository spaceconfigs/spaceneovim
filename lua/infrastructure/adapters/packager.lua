local vim = vim
local lazy = require("infrastructure.plugins.lazy")

---@type PackagerAdapter
local M = {
	install = function()
		lazy.install()
	end,
	update = function()
		lazy.update()
	end,
}

return M
