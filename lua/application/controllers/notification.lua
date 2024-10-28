local M = {}

local logger_use_case = require("application.use_cases.logger")
local notification_use_case = require("application.use_cases.notification")

M.list = function()
	return function()
		local message = {
			module = "controllers/notification",
			func = "list",
		}
		logger_use_case.debug(message)
		notification_use_case.list()
	end
end

M.dismiss = function()
	return function()
		local message = {
			module = "controllers/notification",
			func = "dismiss",
		}
		logger_use_case.debug(message)
		notification_use_case.dismiss()
	end
end

M.notify = function(opts)
	return function()
		local message = {
			module = "controllers/notification",
			func = "notify",
			opts = opts,
		}
		logger_use_case.debug(message)
		notification_use_case.notify(opts)
	end
end

M.debug = function(message)
	return function()
		local log_message = {
			module = "controllers/notification",
			func = "debug",
		}
		logger_use_case.debug(log_message)
		notification_use_case.debug(message)
	end
end

M.info = function(message)
	return function()
		local log_message = {
			module = "controllers/notification",
			func = "info",
		}
		logger_use_case.debug(log_message)
		notification_use_case.info(message)
	end
end

M.warn = function(message)
	return function()
		local log_message = {
			module = "controllers/notification",
			func = "warn",
		}
		logger_use_case.debug(log_message)
		notification_use_case.warn(message)
	end
end

M.error = function(message)
	return function()
		local log_message = {
			module = "controllers/notification",
			func = "error",
		}
		logger_use_case.debug(log_message)
		notification_use_case.error(message)
	end
end

return M
