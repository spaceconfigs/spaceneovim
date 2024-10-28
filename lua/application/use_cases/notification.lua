local M = {}

local log_levels = require("domain.log_levels")

M.setup = function()
	return require("infraestrucuture.adapters.notification")
end

M.list = function()
	local adapter = M.setup()

	adapter.list()
end

M.dismiss = function()
	local adapter = M.setup()

	adapter.dismiss()
end

M.notify = function(opts)
	local adapter = M.setup()
	local level = opts.level
	local message = opts.message

	adapter.notify({
		message = vim.inspect(message),
		level = level,
	})
end

M.debug = function(message)
	M.notify({ message = message, level = log_levels.DEBUG })
end

M.info = function(message)
	M.notify({ message = message, level = log_levels.INFO })
end

M.warn = function(message)
	M.notify({ message = message, level = log_levels.WARN })
end

M.error = function(message)
	M.notify({ message = message, level = log_levels.ERROR })
end

return M
