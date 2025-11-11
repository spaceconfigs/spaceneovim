local M = {}

local logger_use_case = require("application.use_cases.logger")
local file_util = require("infraestrucuture.utils.file")

M.setup = function()
	return require("infraestrucuture.adapters.tree")
end

M.open = function()
	local message = {
		module = "use_cases/tree",
		func = "open",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.open()
end

M.close = function()
	local message = {
		module = "use_cases/tree",
		func = "close",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()
	adapter.close()
end

M.toggle = function(opts)
	return function()
		local message = {
			module = "use_cases/tree",
			func = "toggle",
			opts = opts,
		}
    opts = opts or {}
    opts.location = opts.location or "project"

		logger_use_case.debug(message)

		local adapter = M.setup()
		local path = file_util.project(opts.location)

		adapter.toggle({ location = path })
	end
end

return M
