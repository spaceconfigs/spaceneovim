local M = {}

local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.theme")

M.list = function()
	plugin.themery()
end

M.load = function()
end

return make_logged("adapters/theme", M)
