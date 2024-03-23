local M = {}

local structlog = require("infraestrucuture.plugins.structlog")
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
	structlog:debug(opts.message)
end

M.info = function(opts)
	structlog:info(opts.message)
end

M.warn = function(opts)
	structlog:warn(opts.message)
end

M.error = function(opts)
	structlog:error(opts.message)
end

return M
