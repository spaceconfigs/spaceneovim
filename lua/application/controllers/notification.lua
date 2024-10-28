local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local notification_use_case = require("application.use_cases.notification")

M.list = function()
	return function()
		notification_use_case.list()
	end
end

M.dismiss = function()
	return function()
		notification_use_case.dismiss()
	end
end

M.notify = function(opts)
	return function()
		notification_use_case.notify(opts)
	end
end

M.debug = function(message)
	return function()
		notification_use_case.debug(message)
	end
end

M.info = function(message)
	return function()
		notification_use_case.info(message)
	end
end

M.warn = function(message)
	return function()
		notification_use_case.warn(message)
	end
end

M.error = function(message)
	return function()
		notification_use_case.error(message)
	end
end

return make_controller_logged("notification", M)
