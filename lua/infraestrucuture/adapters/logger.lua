local M = {}

local log_levels = require("domain.log_levels")

local setup = function()
	return require("infraestrucuture.plugins.logger")
end

M.log = function(opts)
	local level = opts.level
	local message = opts.message

	local levels_mapper = {
		[log_levels.DEBUG] = M.debug,
		[log_levels.INFO] = M.info,
		[log_levels.WARN] = M.warn,
		[log_levels.ERROR] = M.error,
	}

	levels_mapper[level]({ message = message })
end

M.debug = function(opts)
	local plugin = setup()
	plugin:debug(opts.message)
end

M.info = function(opts)
	local plugin = setup()

	plugin:info(opts.message)
end

M.warn = function(opts)
	local plugin = setup()

	plugin:warn(opts.message)
end

M.error = function(opts)
	local plugin = setup()

	plugin:error(opts.message)
end

return M
