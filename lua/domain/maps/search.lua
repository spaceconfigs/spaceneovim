local file_use_case = require("application.use_cases.file")
local workspace_use_case = require("application.use_cases.workspace")

local grep_input_content = {
	{ key = "G", description = "Grep input on project" },
	{ key = "Gp", description = "", method = workspace_use_case.grep_input },
}

local search_content = {
	{ key = "p", description = "Search in workspace", method = workspace_use_case.search },
	{ key = "P", description = "Search project w/ input", method = workspace_use_case.search_hover },
	{ key = "s", description = "Text", method = file_use_case.search },
	{ key = "S", description = "Search w/ input", method = file_use_case.search_hover },
}

local result = {}
table.insert(result, {
	key = "<leader>s",
	description = "Search",
	mode = "n",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
})

local contents = {}
for _, content in pairs({
	grep_input_content,
	search_content,
}) do
	for _, bind in pairs(content) do
		table.insert(contents, bind)
	end
end

for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "<leader>s" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = true
	table.insert(result, bind)
end

return result
