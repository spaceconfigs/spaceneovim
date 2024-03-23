local todo_use_case = require("application.use_cases.todo")

local org_content = {
	{ key = "o", description = "Org" },
	{ key = "ot", description = "TODO list", method = todo_use_case.list },
}

local result = {}
local contents = {}
for _, content in pairs({
	org_content,
}) do
	for _, bind in pairs(content) do
		table.insert(contents, bind)
	end
end

table.insert(result, {
	key = "<leader>a",
	description = "Application",
	mode = "n",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
})
for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "<leader>a" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = true
	table.insert(result, bind)
end

return result
