---@type NoterUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
	setup = function()
		return require("application.ports.adapter_registry").noter()
	end,

	new = function()
		local adapter = M.setup()

	  adapter.new()
	end,

	list = function()
		local adapter = M.setup()

		adapter.list()
	end,

	dismiss = function()
		local adapter = M.setup()

		adapter.dismiss()
	end,

	find = function()
		local adapter = M.setup()

		adapter.find()
	end,

	toggle_checkbox = function()
		local adapter = M.setup()

		adapter.checkbox("toggle")
	end,

	todo_next_state = function()
		local adapter = M.setup()

		adapter.todo("next_state")
	end,

	insert_heading = function()
		local adapter = M.setup()

		adapter.insert_heading("same")
	end,
}

return make_logged("usecases/noter", M)
