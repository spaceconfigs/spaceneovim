local M = {}
local make_logged = require("application.helpers.make_logged")

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

return make_logged("use_cases/diagnostic", M)
