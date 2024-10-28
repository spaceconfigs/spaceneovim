local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infraestrucuture.adapters.versior")
end

M.blame_line = function()
	local message = {
		module = "use_cases/versior",
		func = "blame_line",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.blame_line()
end

M.open = function()
	local message = {
		module = "use_cases/versior",
		func = "open",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.open()
end

M.stage_file = function()
	local message = {
		module = "use_cases/versior",
		func = "stage_file",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.stage_files()
end

M.unstage_file = function()
	local message = {
		module = "use_cases/versior",
		func = "unstage_file",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.unstage_files()
end

return M
