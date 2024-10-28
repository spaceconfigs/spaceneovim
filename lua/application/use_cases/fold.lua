local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("infrastructure.adapters.fold")
end

M.fold = function(action, opts)
	opts = opts or {}
	opts.location = opts.location or "cursor"

	local adapter = M.setup()

	adapter.fold(action, opts)
end

return make_logged("use_cases/fold", M)
