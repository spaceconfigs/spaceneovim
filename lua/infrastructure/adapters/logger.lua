local plugin = require("infrastructure.plugins.logger")
local log_levels = require("domain.log_levels")

---@type LoggerAdapter
local M
M = {
	log = function(opts)
		local level = opts.level
		local message = opts.message

		local levels_mapper = {
			[log_levels.DEBUG] = M.debug,
			[log_levels.INFO] = M.info,
			[log_levels.WARN] = M.warn,
			[log_levels.ERROR] = M.error,
		}

		levels_mapper[level]({ message = message })
	end,
	debug = function(opts)
		plugin:debug(opts.message)
	end,
	info = function(opts)
		plugin:info(opts.message)
	end,
	warn = function(opts)
		plugin:warn(opts.message)
	end,
	error = function(opts)
		plugin:error(opts.message)
	end,
}

return M
