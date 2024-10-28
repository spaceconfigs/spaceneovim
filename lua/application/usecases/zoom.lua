local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("application.ports.registry").zoom()
end

---@param opts? { delta?: integer }
M.change = function(opts)
	opts = opts or {}
	opts.delta = opts.delta or 1

	local adapter = M.setup()

	adapter.change(opts)
end

return make_logged("usecases/zoom", M)
