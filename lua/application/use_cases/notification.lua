local M = {}

local log_levels = require("domain.log_levels")

M.setup = function()
	return require("infrastructure.adapters.notification")
end

M.list = function()
	local adapter = M.setup()

	adapter.list()
end

M.dismiss = function()
	local adapter = M.setup()

	adapter.dismiss()
end

---@param opts { message: any, level: LogLevel }
M.notify = function(opts)
	local adapter = M.setup()
	local level = opts.level
	local message = opts.message

	adapter.notify({
		message = type(message) == "string" and message or vim.inspect(message),
		level = level,
	})
end

---@param message any
M.debug = function(message)
	M.notify({ message = message, level = log_levels.DEBUG })
end

---@param message any
M.info = function(message)
	M.notify({ message = message, level = log_levels.INFO })
end

---@param message any
M.warn = function(message)
	M.notify({ message = message, level = log_levels.WARN })
end

---@param message any
M.error = function(message)
	M.notify({ message = message, level = log_levels.ERROR })
end

return M
