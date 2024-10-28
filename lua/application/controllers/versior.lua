local M = {}

local logger_use_case = require("application.use_cases.logger")
local versior_use_case = require("application.use_cases.versior")

M.blame = function(opts)
	return function()
		local message = {
			module = "controllers/versior",
			func = "blame",
			opts = opts,
		}
		logger_use_case.debug(message)
		versior_use_case.blame(opts)
	end
end

M.open = function()
	return function()
		local message = {
			module = "controllers/versior",
			func = "open",
		}
		logger_use_case.debug(message)
		versior_use_case.open()
	end
end

M.stage_file = function()
	return function()
		local message = {
			module = "controllers/versior",
			func = "stage_file",
		}
		logger_use_case.debug(message)
		versior_use_case.stage_file()
	end
end

M.unstage_file = function()
	return function()
		local message = {
			module = "controllers/versior",
			func = "unstage_file",
		}
		logger_use_case.debug(message)
		versior_use_case.unstage_file()
	end
end

M.browse = function()
	return function()
		local message = {
			module = "controllers/versior",
			func = "browse",
		}
		logger_use_case.debug(message)
		versior_use_case.browse()
	end
end

M.branches = function()
	return function()
		local message = {
			module = "controllers/versior",
			func = "branches",
		}
		logger_use_case.debug(message)
		versior_use_case.branches()
	end
end

M.log = function()
	return function()
		local message = {
			module = "controllers/versior",
			func = "log",
		}
		logger_use_case.debug(message)
		versior_use_case.log()
	end
end

return M
