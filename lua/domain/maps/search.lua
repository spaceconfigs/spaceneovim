local searcher_use_case = require("application.use_cases.searcher")
local workspace_use_case = require("application.use_cases.workspace")

local grep_input_content = {
	{ key = "G", description = "Grep input on project" },
	{ key = "Gp", description = "", method = workspace_use_case.grep_input },
}

local search_content = {
	{
		key = "d",
		description = "Directory",
		method = searcher_use_case.search({ location = "directory" }),
	},
	{
		key = "D",
		description = "Directory",
		method = searcher_use_case.search_hover({ location = "directory" }),
	},
	{ key = "l", description = "Resume", method = searcher_use_case.resume() },
	{
		key = "p",
		description = "Search in workspace",
		method = searcher_use_case.search({ location = "project", in_live = true }),
	},
	{
		key = "P",
		description = "Search project w/ input",
		method = searcher_use_case.search_hover({ location = "project" }),
	},
	{ key = "s", description = "Text", method = searcher_use_case.search({ in_live = true }) },
	{ key = "S", description = "Search w/ input", method = searcher_use_case.search_hover() },
}

local result = {}
table.insert(result, {
	key = "<leader>s",
	description = "Search",
	mode = "n",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
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
	bind.nowait = false
	table.insert(result, bind)
end

return result
