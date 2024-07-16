local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infraestrucuture.adapters.terminal")
end

M.open = function()
	local message = {
		module = "use_cases/terminal",
		func = "open",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.open()
end

M.close = function()
	local message = {
		module = "use_cases/terminal",
		func = "close",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.close()
end

M.toggle = function()
	local message = {
		module = "use_cases/terminal",
		func = "toggle",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.toggle()
end

M.toggle_buffer_dir = function()
	local message = {
		module = "use_cases/terminal",
		func = "toggle_buffer_dir",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.toggle_buffer_dir()
end

return M
