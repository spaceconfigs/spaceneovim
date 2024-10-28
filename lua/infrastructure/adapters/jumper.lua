local make_logged = require("application.helpers.make_logged")
local jump = require("infrastructure.plugins.jump")
local hop = jump.hop
local flash = jump.flash

---@type JumperPort
local M = {
	timer = function(options)
		flash.jump({
			action = options.action,
		})
	end,
	words = function()
		hop.hint_char1({ multi_windows = true })
	end,
	lines = function()
		hop.hint_lines()
	end,
	remote = function()
		flash.remote()
	end,
}

return make_logged("adapters/jumper", M)
