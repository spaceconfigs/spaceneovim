local M = {}

local logger_use_case = require("application.use_cases.logger")
local file_use_case = require("application.use_cases.file")

M.oldfiles = function(opts)
	return function()
		local message = {
			module = "controllers/file",
			func = "oldfiles",
			opts = opts,
		}
		logger_use_case.debug(message)
		file_use_case.oldfiles(opts)
	end
end

M.list = function(opts)
	return function()
		local message = {
			module = "controllers/file",
			func = "list",
			opts = opts,
		}
		logger_use_case.debug(message)
		file_use_case.list(opts)
	end
end

M.search = function()
	return function()
		local message = {
			module = "controllers/file",
			func = "search",
		}
		logger_use_case.debug(message)
		file_use_case.search()
	end
end

M.search_hover = function()
	return function()
		local message = {
			module = "controllers/file",
			func = "search_hover",
		}
		logger_use_case.debug(message)
		file_use_case.search_hover()
	end
end

M.rename = function()
	return function()
		local message = {
			module = "controllers/file",
			func = "rename",
		}
		logger_use_case.debug(message)
		file_use_case.rename()
	end
end

M.edit_config = function()
	return function()
		local message = {
			module = "controllers/file",
			func = "edit_config",
		}
		logger_use_case.debug(message)
		file_use_case.edit_config()
	end
end

M.source_config = function()
	return function()
		local message = {
			module = "controllers/file",
			func = "source_config",
		}
		logger_use_case.debug(message)
		file_use_case.source_config()
	end
end

M.delete_current = function()
	return function()
		local message = {
			module = "controllers/file",
			func = "delete_current",
		}
		logger_use_case.debug(message)
		file_use_case.delete_current()
	end
end

M.save = function()
	return function()
		local message = {
			module = "controllers/file",
			func = "save",
		}
		logger_use_case.debug(message)
		file_use_case.save()
	end
end

M.save_all = function()
	return function()
		local message = {
			module = "controllers/file",
			func = "save_all",
		}
		logger_use_case.debug(message)
		file_use_case.save_all()
	end
end

M.copy = function(opts)
	return function()
		local message = {
			module = "controllers/file",
			func = "copy",
			opts = opts,
		}
		logger_use_case.debug(message)
		file_use_case.copy(opts)
	end
end

return M
