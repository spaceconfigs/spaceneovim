local M = {}

M.setup = function()
	return require("infrastructure.adapters.formatter")
end

M.format = function()
	local adapter = M.setup()

	adapter.format()
end

return M
