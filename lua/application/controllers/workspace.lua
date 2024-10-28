local M = {}

local logger_use_case = require("application.use_cases.logger")
local workspace_use_case = require("application.use_cases.workspace")

M.add = function()
	return function()
		local message = {
			module = "controllers/workspace",
			func = "add",
		}
		logger_use_case.debug(message)
		workspace_use_case.add()
	end
end

M.open = function()
	return function()
		local message = {
			module = "controllers/workspace",
			func = "open",
		}
		logger_use_case.debug(message)
		workspace_use_case.open()
	end
end

M.files = function()
	return function()
		local message = {
			module = "controllers/workspace",
			func = "files",
		}
		logger_use_case.debug(message)
		workspace_use_case.files()
	end
end

M.grep_input = function()
	return function()
		local message = {
			module = "controllers/workspace",
			func = "grep_input",
		}
		logger_use_case.debug(message)
		workspace_use_case.grep_input()
	end
end

M.diagnostics = function()
	return function()
		local message = {
			module = "controllers/workspace",
			func = "diagnostics",
		}
		logger_use_case.debug(message)
		workspace_use_case.diagnostics()
	end
end

M.add_and_toggle_tree = function()
	return function()
		local message = {
			module = "controllers/workspace",
			func = "add_and_toggle_tree",
		}
		logger_use_case.debug(message)
		workspace_use_case.add_and_toggle_tree()
	end
end

return M
