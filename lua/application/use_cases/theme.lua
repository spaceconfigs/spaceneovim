local M = {}

M.setup = function()
	return require("infrastructure.adapters.theme")
end

M.list = function()
	local adapter = M.setup()

	adapter.list()
end

M.load = function()
	local adapter = M.setup()

	adapter.load()
end

return M
