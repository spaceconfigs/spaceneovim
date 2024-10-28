local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("application.ports.registry").noter()
end

M.new = function()
	local adapter = M.setup()

  adapter.new()
end

M.list = function()
	local adapter = M.setup()

	adapter.list()
end

M.dismiss = function()
	local adapter = M.setup()

	adapter.dismiss()
end

M.find = function()
	local adapter = M.setup()

	adapter.find()
end

M.toggle_checkbox = function()
	local adapter = M.setup()

	adapter.checkbox("toggle")
end

M.todo_next_state = function()
	local adapter = M.setup()

	adapter.todo("next_state")
end

M.insert_heading = function()
	local adapter = M.setup()

	adapter.insert_heading("same")
end

return make_logged("use_cases/noter", M)
