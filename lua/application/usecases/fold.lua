local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("application.ports.adapter_registry").fold()
end

---@param action "open"|"close"|"toggle"
---@param opts? { location?: "cursor"|"all" }
M.fold = function(action, opts)
	opts = opts or {}
	opts.location = opts.location or "cursor"

	local adapter = M.setup()

	adapter.fold(action, opts)
end

return make_logged("usecases/fold", M)
