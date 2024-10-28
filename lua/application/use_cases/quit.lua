local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("infrastructure.adapters.quit")
end

M.quit = function(opts)
	local adapter = M.setup()

	adapter.quit(opts)
end

return make_logged("use_cases/quit", M)
