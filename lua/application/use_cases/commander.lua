local M = {}

M.setup = function()
	return require("infrastructure.adapters.commander")
end

M.find = function()
	local adapter = M.setup()

	adapter.find()
end

return M
