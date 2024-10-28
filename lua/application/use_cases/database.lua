local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("infrastructure.adapters.database")
end

M.open = function()
	local adapter = M.setup()

	adapter.open()
end

return make_logged("use_cases/database", M)
