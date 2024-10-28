local M = {}

local logger_use_case = require("application.use_cases.logger")
local buffer_use_case = require("application.use_cases.buffer")

M.add = function()
	return function()
		local message = {
			module = "controllers/buffer",
			func = "add",
		}
		logger_use_case.debug(message)
		buffer_use_case.add()
	end
end

M.delete = function()
	return function()
		local message = {
			module = "controllers/buffer",
			func = "delete",
		}
		logger_use_case.debug(message)
		buffer_use_case.delete()
	end
end

M.close_others = function()
	return function()
		local message = {
			module = "controllers/buffer",
			func = "close_others",
		}
		logger_use_case.debug(message)
		buffer_use_case.close_others()
	end
end

M.list = function()
	return function()
		local message = {
			module = "controllers/buffer",
			func = "list",
		}
		logger_use_case.debug(message)
		buffer_use_case.list()
	end
end

M.next = function()
	return function()
		local message = {
			module = "controllers/buffer",
			func = "next",
		}
		logger_use_case.debug(message)
		buffer_use_case.next()
	end
end

M.previous = function()
	return function()
		local message = {
			module = "controllers/buffer",
			func = "previous",
		}
		logger_use_case.debug(message)
		buffer_use_case.previous()
	end
end

M.messages = function()
	return function()
		local message = {
			module = "controllers/buffer",
			func = "messages",
		}
		logger_use_case.debug(message)
		buffer_use_case.messages()
	end
end

M.reopen = function()
	return function()
		local message = {
			module = "controllers/buffer",
			func = "reopen",
		}
		logger_use_case.debug(message)
		buffer_use_case.reopen()
	end
end

return M
