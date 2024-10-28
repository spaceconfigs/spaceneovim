local M = {}

local adapter = require("application.ports.registry").keymapper()
local logger_usecase = require("application.use_cases.logger")

---@param opts KeyBind
M.format = function(opts)
	local map = adapter.format(opts)
	return map
end

---@param map KeyBind
M.register = function(map)
	adapter.register(map)
end

---@param map KeyBind[]
M.register_all = function(map)
	adapter.register_all(map)
end

---@param opts TransientConfig
M.create_transient = function(opts)
	local message = {
		module = "use_cases/keymapper",
		func = "create_transient",
		opts = opts,
	}
	logger_usecase.debug(message)

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

---@param opts { mode: string, key: string, action: any, noremap?: boolean, silent?: boolean }
M.set = function(opts)
	adapter.set(opts)
end

---@param opts { mode: string, key: string }
M.unset = function(opts)
	adapter.unset(opts)
end

return M
