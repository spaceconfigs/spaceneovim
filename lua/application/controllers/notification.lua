local make_controller_logged = require("application.helpers.make_controller_logged")
local notification_use_case = require("application.use_cases.notification")

---@type NotificationContract
local M = {
	list = function()
		return function()
			notification_use_case.list()
		end
	end,

	dismiss = function()
		return function()
			notification_use_case.dismiss()
		end
	end,

	notify = function(opts)
		return function()
			notification_use_case.notify(opts)
		end
	end,

	debug = function(message)
		return function()
			notification_use_case.debug(message)
		end
	end,

	info = function(message)
		return function()
			notification_use_case.info(message)
		end
	end,

	warn = function(message)
		return function()
			notification_use_case.warn(message)
		end
	end,

	error = function(message)
		return function()
			notification_use_case.error(message)
		end
	end,
}

return make_controller_logged("notification", M)
