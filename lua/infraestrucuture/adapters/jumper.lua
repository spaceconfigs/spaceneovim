local M = {}

local logger_use_manage = require("application.use_cases.logger")

local setup = function()
	return require("infraestrucuture.plugins.jump")
end

M.timer = function()
	local message = {
		module = "adapters/jumper",
		func = "words",
	}
	logger_use_manage.debug(message)
	local plugin = setup().flash

	plugin.jump()
end

M.words = function()
	local message = {
		module = "adapters/jumper",
		func = "words",
	}
	logger_use_manage.debug(message)
	local plugin = setup().hop

	plugin.hint_char1({ multi_windows = true })
end

M.lines = function()
	local message = {
		module = "adapters/jumper",
		func = "lines",
	}
	logger_use_manage.debug(message)
	local plugin = setup().hop

	plugin.hint_lines()
end

return M
