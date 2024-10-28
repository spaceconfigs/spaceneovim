local M = {}

local make_logged = require("application.helpers.make_logged")
local jump = require("infrastructure.plugins.jump")
local hop = jump.hop
local flash = jump.flash

M.timer = function(options)
	flash.jump({
		action = options.action,
	})
end

M.words = function()
	hop.hint_char1({ multi_windows = true })
end

M.lines = function()
	hop.hint_lines()
end

M.remote = function()
	flash.remote()
end

return make_logged("adapters/jumper", M)
