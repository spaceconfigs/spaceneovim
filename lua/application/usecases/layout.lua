---@type LayoutUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
	setup = function()
		return require("application.ports.adapter_registry").layout()
	end,

	list = function()
		local adapter = M.setup()

		adapter.list()
	end,

	reload = function()
		local adapter = M.setup()

		adapter.reload()
	end,

	save = function()
		local adapter = M.setup()

		adapter.save()
	end,

	delete = function()
		local adapter = M.setup()

		adapter.delete()
	end,

	rename = function()
		local adapter = M.setup()

		adapter.rename()
	end,

	previous = function()
		local adapter = M.setup()

		adapter.previous()
	end,
}
return make_logged("usecases/layout", M)
