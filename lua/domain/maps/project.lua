local clone = require("domain.utils.table").clone
local terminal = require("domain.contracts.registry").terminal()
local workspace = require("domain.contracts.registry").workspace()
---@return KeyBind[]
return function()
	---@type KeyBind[]
	local project_content = {
		{ key = "'", description = "Terminal", method = terminal.toggle({ location = "project" }) },
		{
			key = '"',
			description = "Terminal",
			method = terminal.toggle({ location = "project", type = "external" }),
		},
		{ key = "E", description = "Diagnostics", method = workspace.diagnostics() },
		{ key = "f", description = "Find File", method = workspace.files() },
		{ key = "p", description = "Find Projects", method = workspace.open() },
		{ key = "t", description = "Tree", method = workspace.add_and_toggle_tree() },
	}

	local result = {}
	local contents = {}
	for _, content in pairs({
		project_content,
	}) do
		for _, bind in pairs(content) do
			table.insert(contents, bind)
		end
	end

	table.insert(result, {
		key = "<leader>p",
		description = "Project",
		mode = "n",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
	})
	for _, content in pairs(contents) do
		local bind = clone(content)
		bind.key = "<leader>p" .. bind.key
		bind.mode = "n"
		bind.buffer = nil
		bind.silent = true
		bind.noremap = true
		bind.nowait = false
		table.insert(result, bind)
	end

	return result
end
