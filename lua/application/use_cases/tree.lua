local M = {}

local logger_use_case = require("application.use_cases.logger")
local adapter = require("infraestrucuture.adapters.tree")
local file_util = require("infraestrucuture.utils.file")

M.open = function()
	local message = {
		module = "use_cases/tree",
		func = "open",
	}
	logger_use_case.debug(message)

	adapter.open()
end

M.close = function()
	local message = {
		module = "use_cases/tree",
		func = "close",
	}
	logger_use_case.debug(message)
	adapter.close()
end

M.toggle = function(opts)
	return function()
		local message = {
			module = "adapters/todo",
			func = "toggle",
			opts = opts,
		}
		logger_use_case.debug(message)
		local path = file_util.get_path(opts)

		adapter.toggle({ location = path })
	end
end

return M
