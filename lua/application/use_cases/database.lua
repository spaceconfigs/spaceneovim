local M = {}

M.setup = function()
	return require("infrastructure.adapters.database")
end

M.open = function()
	local adapter = M.setup()

	adapter.open()
end

return M
