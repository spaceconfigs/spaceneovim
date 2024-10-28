local M = {}

local environments = require("domain.environments")
local log_levels = require("domain.log_levels")
local notification_use_case = require("application.use_cases.notification")

M.setup = function()
	return require("infraestrucuture.adapters.logger")
end

M.log = function(opts)
	local adapter = M.setup()

	local level = opts.level
	local message = opts.message
	local environment_log_levels_mapper = {

		[environments.PRODUCTION] = {
			log_levels.WARN,
			log_levels.ERROR,
			log_levels.INFO,
		},
		[environments.DEVELOPMENT] = {
			log_levels.WARN,
			log_levels.ERROR,
			log_levels.INFO,
			log_levels.DEBUG,
		},
	}

	local environment = vim.fn.getenv("NVIM_ENVIRONMENT")
	local log_level = environment_log_levels_mapper[environment] or {}
	for _, value in pairs(log_level) do
		if value ~= level then
			goto continue
		end

		notification_use_case.notify({
			message = message,
			level = level,
		})
		adapter.log({
			message = vim.inspect(message),
			level = level,
		})

		::continue::
	end
end

M.debug = function(message)
	M.log({ message = message, level = log_levels.DEBUG })
end

M.info = function(message)
	M.log({ message = message, level = log_levels.INFO })
end

M.warn = function(message)
	M.log({ message = message, level = log_levels.WARN })
end

M.error = function(message)
	M.log({ message = message, level = log_levels.ERROR })
end

return M
