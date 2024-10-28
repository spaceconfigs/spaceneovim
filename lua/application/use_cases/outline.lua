local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("infrastructure.adapters.outline")
end

M.toggle = function()
	local adapter = M.setup()

	adapter.toggle()
end

return make_logged("use_cases/outline", M)
