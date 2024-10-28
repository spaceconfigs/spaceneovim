local M = {}

local file_util = require("infrastructure.utils.file")

M.setup = function()
	return require("infrastructure.adapters.tree")
end

M.open = function()
	local adapter = M.setup()

	adapter.open()
end

M.close = function()
	local adapter = M.setup()
	adapter.close()
end

M.toggle = function(opts)
	opts = opts or {}
	opts.location = opts.location or "project"

	local adapter = M.setup()
	local path = file_util.project(opts.location)

	adapter.toggle({ location = path })
end

return M
