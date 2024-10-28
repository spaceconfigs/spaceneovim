local terminal_controller = require("application.controllers.terminal")
local workspace_controller = require("application.controllers.workspace")

local project_content = {
	{ key = "'", description = "Terminal", method = terminal_controller.toggle({ location = "project" }) },
	{
		key = '"',
		description = "Terminal",
		method = terminal_controller.toggle({ location = "project", type = "external" }),
	},
	{ key = "E", description = "Diagnostics", method = workspace_controller.diagnostics() },
	{ key = "f", description = "Find File", method = workspace_controller.files() },
	{ key = "p", description = "Find Projects", method = workspace_controller.open() },
	{ key = "t", description = "Tree", method = workspace_controller.add_and_toggle_tree() },
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
	local bind = vim.deepcopy(content)
	bind.key = "<leader>p" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = false
	table.insert(result, bind)
end

return result
