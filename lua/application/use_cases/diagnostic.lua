local M = {}

M.setup = function()
	return require("infrastructure.adapters.diagnostic")
end

M.toggle = function()
	local adapter = M.setup()

	adapter.toggle()
end

M.show = function(direction)
	local adapter = M.setup()

	adapter.show(direction)
end

M.loclist = function()
	local adapter = M.setup()

	adapter.loclist()
end

return M
