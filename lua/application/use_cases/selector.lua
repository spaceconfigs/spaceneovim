local M = {}
local make_logged = require("application.helpers.make_logged")

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

return make_logged("use_cases/selector", M)
