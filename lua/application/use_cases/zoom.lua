local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("infrastructure.adapters.zoom")
end

M.change = function(opts)
	opts = opts or {}
	opts.delta = opts.delta or 1

	local adapter = M.setup()

	adapter.change(opts)
end

return make_logged("use_cases/zoom", M)
