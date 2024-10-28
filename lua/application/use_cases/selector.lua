local M = {}

M.setup = function()
	return require("infrastructure.adapters.selector")
end

M.quit = function()
	local adapter = M.setup()

	adapter.quit()
end

M.all_selected = function()
	local adapter = M.setup()

	adapter.all_selected()
end

return M
