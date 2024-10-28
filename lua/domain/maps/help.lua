local documentation_use_case = require("application.use_cases.documentation")

local help_content = {
	{ key = "b", description = "Prefix" },
	{ key = "bd", description = "Devdocs", method = documentation_use_case.open },
}

local contents = {}
local result = {}
for _, content in pairs({
	help_content,
}) do
	for _, bind in pairs(content) do
		table.insert(contents, bind)
	end
end

table.insert(result, {
	key = "<leader>h",
	description = "Help",
	mode = "n",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
})

for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "<leader>h" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = false
	table.insert(result, bind)
end

return result
