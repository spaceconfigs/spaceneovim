local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infraestrucuture.adapters.versior")
end

M.blame = function(opts)
	return function()
		opts = opts or {}
		opts.location = opts.location or "file"
		local message = {
			module = "use_cases/versior",
			func = "blame",
			opts = opts,
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.blame(opts)
	end
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

M.browse = function()
	local message = {
		module = "use_cases/versior",
		func = "browse",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.browse()
end

M.branches = function()
	local message = {
		module = "use_cases/versior",
		func = "unstage_file",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.branches()
end

M.log = function()
	local message = {
		module = "use_cases/versior",
		func = "log",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.log()
end

return M
