local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("infrastructure.adapters.theme")
end

M.list = function()
	local adapter = M.setup()

	adapter.list()
end

M.load = function()
	local adapter = M.setup()

	adapter.load()
end

return make_logged("use_cases/theme", M)
