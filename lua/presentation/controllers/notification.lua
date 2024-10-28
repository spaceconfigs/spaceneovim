local make_controller_logged = require("application.helpers.make_controller_logged")
local notification_usecase = require("application.ports.use_case_registry").notification()

---@type NotificationContract
local M = {
	list = function()
		return function()
			notification_usecase.list()
		end
	end,

	dismiss = function()
		return function()
			notification_usecase.dismiss()
		end
	end,

	notify = function(opts)
		return function()
			notification_usecase.notify(opts)
		end
	end,

	debug = function(message)
		return function()
			notification_usecase.debug(message)
		end
	end,

	info = function(message)
		return function()
			notification_usecase.info(message)
		end
	end,

	warn = function(message)
		return function()
			notification_usecase.warn(message)
		end
	end,

	error = function(message)
		return function()
			notification_usecase.error(message)
		end
	end,
}

return make_controller_logged("notification", M)
