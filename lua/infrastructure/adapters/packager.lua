local vim = vim
local M = {}

local lazy = require("infrastructure.plugins.lazy")

M.install = function()
	lazy.install()
end

M.update = function()
	lazy.update()
end

return M
