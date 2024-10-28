---@type BookmarkerUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
	setup = function()
		return require("application.ports.adapter_registry").bookmarker()
	end,

	add = function()
		local adapter = M.setup()

		adapter.add()
	end,

	remove = function()
		local adapter = M.setup()

		adapter.remove()
	end,

	list = function()
		local adapter = M.setup()

		adapter.list()
	end,
}

return make_logged("usecases/bookmarker", M)
