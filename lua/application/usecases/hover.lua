local M = {}
local make_logged = require("application.helpers.make_logged")

local adapter = require("application.ports.registry").hover()

M.setup = function()
	return require("application.ports.registry").hover()
end

M.toggle = function()
	M.setup()

	adapter.toggle()
end

M.dismiss = function()
	M.setup()

	adapter.dismiss()
end
return make_logged("usecases/hover", M)
