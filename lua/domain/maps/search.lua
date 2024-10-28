local searcher_controller = require("application.controllers.searcher")
local workspace_controller = require("application.controllers.workspace")

local grep_input_content = {
	{ key = "G", description = "Grep input on project" },
	{ key = "Gp", description = "Grep in [p]roject", method = workspace_controller.grep_input() },
}

local search_content = {
	{
		key = "d",
		description = "[d]irectory",
		method = searcher_controller.search({ location = "directory" }),
	},
	{
		key = "D",
		description = "[D]irectory w/ input",
		method = searcher_controller.search_hover({ location = "directory" }),
	},
	{ key = "l", description = "Resume ([l]ast)", method = searcher_controller.resume() },
	{
		key = "p",
		description = "Search in [p]roject",
		method = searcher_controller.search({ location = "project", in_live = true }),
	},
	{
		key = "P",
		description = "Search [P]roject w/ input",
		method = searcher_controller.search_hover({ location = "project" }),
	},
	{ key = "s", description = "Text ([s]earch)", method = searcher_controller.search({ in_live = true }) },
	{ key = "S", description = "[S]earch w/ input", method = searcher_controller.search_hover() },
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
