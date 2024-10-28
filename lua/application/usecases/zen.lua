local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("application.ports.registry").zen()
end

M.toggle = function()
	local adapter = M.setup()

	adapter.toggle()
end

M.center = function()
	local adapter = M.setup()

	adapter.center()
end

M.area = function()
	local adapter = M.setup()

	adapter.area()
end

return make_logged("usecases/zen", M)
