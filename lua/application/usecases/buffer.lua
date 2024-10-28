---@type BufferUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
	setup = function()
		return require("application.ports.adapter_registry").buffer()
	end,

	add = function()
		local adapter = M.setup()

		adapter.add()
	end,

	delete = function()
		local adapter = M.setup()

		adapter.delete()
	end,

	close_others = function()
		local adapter = M.setup()

		adapter.close_others()
	end,

	list = function()
		local adapter = M.setup()

		adapter.list()
	end,

	next = function()
		local adapter = M.setup()

		adapter.next()
	end,

	previous = function()
		local adapter = M.setup()

		adapter.previous()
	end,

	messages = function()
		local adapter = M.setup()

		adapter.messages()
	end,

	reopen = function()
		local adapter = M.setup()

		adapter.reopen()
	end,
}

return make_logged("usecases/buffer", M)
