local M = {}

M.setup = function()
	return require("infrastructure.adapters.toggler")
end

M.number = function()
	local adapter = M.setup()

	adapter.number()
end

M.wrap = function()
	local adapter = M.setup()

	adapter.wrap()
end

return M
