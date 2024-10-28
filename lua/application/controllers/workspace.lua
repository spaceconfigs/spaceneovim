local make_controller_logged = require("application.helpers.make_controller_logged")
local workspace_use_case = require("application.use_cases.workspace")

---@type WorkspaceContract
local M = {
	add = function()
		return function()
			workspace_use_case.add()
		end
	end,

	open = function()
		return function()
			workspace_use_case.open()
		end
	end,

	files = function()
		return function()
			workspace_use_case.files()
		end
	end,

	grep_input = function()
		return function()
			workspace_use_case.grep_input()
		end
	end,

	diagnostics = function()
		return function()
			workspace_use_case.diagnostics()
		end
	end,

	add_and_toggle_tree = function()
		return function()
			workspace_use_case.add_and_toggle_tree()
		end
	end,
}

return make_controller_logged("workspace", M)
