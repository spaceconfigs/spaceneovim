local M = {}

local make_logged = require("application.helpers.make_logged")
local plugins = require("infrastructure.plugins.outline")
local outline = plugins.outline

M.toggle = function()
	outline.toggle({ focus_outline = false })
end

return make_logged("adapters/outline", M)
