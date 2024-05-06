local terminal_use_case = require("application.use_cases.terminal")
local workspace_use_case = require("application.use_cases.workspace")
local tree_use_case = require("application.use_cases.tree")

local project_content = {
	{ key = "'", description = "Terminal", method = terminal_use_case.toggle },
	{ key = "E", description = "Diagnostics", method = workspace_use_case.diagnostics },
	{ key = "f", description = "Find File", method = workspace_use_case.files },
	{ key = "p", description = "Find Projects", method = workspace_use_case.open },
	{
		key = "t",
		description = "Tree",
		method = function()
			workspace_use_case.add()
			tree_use_case.toggle()
		end,
	},
	-- TODO: add project diagnostic
	-- {
	-- 	key = "E",
	-- 	description = "Diagnostics",
	-- 	method = finder_use_case.diagnostics,
	-- },
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
