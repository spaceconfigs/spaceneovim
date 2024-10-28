local M = {}
local make_logged = require("application.helpers.make_logged")

local adapter = require("infrastructure.adapters.hover")

M.setup = function()
	return require("infrastructure.adapters.hover")
end

M.toggle = function()
	M.setup()

	adapter.toggle()
end

M.dismiss = function()
	M.setup()

	adapter.dismiss()
end
return make_logged("use_cases/hover", M)
