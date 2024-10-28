local M = {}

local adapter = require("infraestrucuture.adapters.keymapper")

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

return M
