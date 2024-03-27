local jumper_use_case = require("application.use_cases.jumper")

local jump_content = {
	{ key = "j", description = "Word", method = jumper_use_case.words, },
	{ key = "l", description = "Line", method = jumper_use_case.lines, },
}

local result = {}
local contents = {}
for _, content in pairs({
	jump_content,
}) do
	for _, bind in pairs(content) do
		table.insert(contents, bind)
	end
end

table.insert(result, {
	key = "<leader>j",
	description = "Jump",
	mode = "n",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
})
for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "<leader>j" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = false
	table.insert(result, bind)
end

return result
