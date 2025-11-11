local M = {}

local adapter = require("infraestrucuture.adapters.keymapper")
local logger_use_case = require("application.use_cases.logger")

M.format = function(opts)
	local map = adapter.format(opts)
	return map
end

M.register = function(map)
	adapter.register(map)
end

M.register_all = function(map)
	adapter.register_all(map)
end

M.create_transient = function(opts)
	local message = {
		module = "use_cases/keymapper",
		func = "create_transient",
		opts = opts,
	}
	logger_use_case.debug(message)

	local config = {
		hint = opts.hint or "",
		config = {
			color = opts.color or "pink",
			-- hint = {
			-- 	position = opts.position or "bottom",
			-- },
		},
		mode = opts.mode or "n",
		heads = opts.heads or {},
	}

	return adapter.create_transient(config)
end

return M
