local jumper_use_case = require("application.use_cases.jumper")

local jump_content = {
	{ key = "j", description = "Timer", method = jumper_use_case.timer },
	{ key = "w", description = "Word", method = jumper_use_case.words },
	{ key = "l", description = "Line", method = jumper_use_case.lines },
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

for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)

	bind.key = "<leader>j" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = false

	table.insert(result, vim.deepcopy(bind))

	bind.mode = "v"
	table.insert(result, vim.deepcopy(bind))
end

return result
