local M = {}

M.setup = function()
	return require("infrastructure.adapters.todo")
end

M.list = function()
	local adapter = M.setup()

	adapter.list()
end

return M
