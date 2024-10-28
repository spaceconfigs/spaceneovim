local make_controller_logged = require("application.helpers.make_controller_logged")
local workspace_usecase = require("application.ports.use_case_registry").workspace()

---@type WorkspaceContract
local M = {
	add = function()
		return function()
			workspace_usecase.add()
		end
	end,

	open = function()
		return function()
			workspace_usecase.open()
		end
	end,

	files = function()
		return function()
			workspace_usecase.files()
		end
	end,

	grep_input = function()
		return function()
			workspace_usecase.grep_input()
		end
	end,

	diagnostics = function()
		return function()
			workspace_usecase.diagnostics()
		end
	end,

	add_and_toggle_tree = function()
		return function()
			workspace_usecase.add_and_toggle_tree()
		end
	end,
}

return make_controller_logged("workspace", M)
