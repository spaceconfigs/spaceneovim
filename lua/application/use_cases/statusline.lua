local M = {}

M.setup = function()
	return require("infrastructure.adapters.statusline")
end

M.toggle = function()
	local adapter = M.setup()

	adapter.toggle()
end

return M
