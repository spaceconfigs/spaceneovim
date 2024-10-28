local M = {}

local plugin = require("infraestrucuture.plugins.logger")
local log_levels = require("domain.log_levels")

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
	plugin:debug(opts.message)
end

M.info = function(opts)
	plugin:info(opts.message)
end

M.warn = function(opts)
	plugin:warn(opts.message)
end

M.error = function(opts)
	plugin:error(opts.message)
end

return M
