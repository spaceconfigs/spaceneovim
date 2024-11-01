local M = {}

local logger_use_manage = require("application.use_cases.logger")
local jump = require("infraestrucuture.plugins.jump")
local hop = jump.hop
local flash = jump.flash

M.timer = function(options)
	local message = {
		module = "adapters/jumper",
		func = "words",
	}
	logger_use_manage.debug(message)

	flash.jump({
		action = options.action,
	})
end

M.words = function()
	local message = {
		module = "adapters/jumper",
		func = "words",
	}
	logger_use_manage.debug(message)

	hop.hint_char1({ multi_windows = true })
end

M.lines = function()
	local message = {
		module = "adapters/jumper",
		func = "lines",
	}
	logger_use_manage.debug(message)

	hop.hint_lines()
end

M.remote = function()
	local message = {
		module = "adapters/jumper",
		func = "remote",
	}
	logger_use_manage.debug(message)

	flash.remote()
end

return M
