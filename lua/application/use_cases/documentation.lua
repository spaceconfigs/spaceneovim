local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("infrastructure.adapters.documentation")
end

M.open = function()
	local adapter = M.setup()

	adapter.open()
end

M.install = function()
	local adapter = M.setup()

	adapter.install()
end

return make_logged("use_cases/documentation", M)
