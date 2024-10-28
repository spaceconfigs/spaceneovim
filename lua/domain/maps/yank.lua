local jumper_use_case = require("application.use_cases.jumper")

local jump_content = {
	{ key = "r", description = "Remote", method = jumper_use_case.remote },
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
	key = "<leader>y",
	description = "Yank",
	mode = "n",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
})

for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)

	bind.key = "<leader>y" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = false

	table.insert(result, vim.deepcopy(bind))
end

return result
