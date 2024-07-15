local theme_use_case = require("application.use_cases.theme")

local toggler_content = {
	{ key = "s", description = "List themes", method = theme_use_case.list },
}

local result = {}
local contents = {}
for _, content in pairs({
	toggler_content,
}) do
	for _, bind in pairs(content) do
		table.insert(contents, bind)
	end
end

table.insert(result, {
	key = "<leader>R",
	description = "UI",
	mode = "n",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
})

for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "<leader>T" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = false
	table.insert(result, bind)
end

return result
