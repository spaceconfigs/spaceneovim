---@type TreeUseCase
local M
local make_logged = require("application.helpers.make_logged")

local file_util = require("application.ports.adapter_registry").file_util()

M = {
	setup = function()
		return require("application.ports.adapter_registry").tree()
	end,

	open = function()
		local adapter = M.setup()

		adapter.open()
	end,

	close = function()
		local adapter = M.setup()
		adapter.close()
	end,

	toggle = function(opts)
		opts = opts or {}
		opts.location = opts.location or "project"

		local adapter = M.setup()
		local path = file_util.project(opts.location)

		adapter.toggle({ location = path })
	end,
}

return make_logged("usecases/tree", M)
