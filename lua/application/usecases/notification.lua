---@type NotificationUseCase
local M

local log_levels = require("domain.log_levels")

M = {
	setup = function()
		return require("application.ports.adapter_registry").notification()
	end,

	list = function()
		local adapter = M.setup()

		adapter.list()
	end,

	dismiss = function()
		local adapter = M.setup()

		adapter.dismiss()
	end,

	notify = function(opts)
		local adapter = M.setup()
		local level = opts.level
		local message = opts.message

		adapter.notify({
			message = message,
			level = level,
		})
	end,

	debug = function(message)
		M.notify({ message = message, level = log_levels.DEBUG })
	end,

	info = function(message)
		M.notify({ message = message, level = log_levels.INFO })
	end,

	warn = function(message)
		M.notify({ message = message, level = log_levels.WARN })
	end,

	error = function(message)
		M.notify({ message = message, level = log_levels.ERROR })
	end,
}

return M
