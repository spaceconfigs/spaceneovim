local use_case = require("application.use_cases.chatbot")

local output_content = {
	{ key = "o", description = "Output" },
	{ key = "og", description = "Toggle", method = use_case.toggle },
	{ key = "oe", mode = "v", description = "Edit", method = use_case.edit },
}
local chatbot_content = {}

local result = {}
local contents = {}
for _, content in pairs({
	output_content,
	chatbot_content,
}) do
	for _, bind in pairs(content) do
		table.insert(contents, bind)
	end
end

table.insert(result, {
	key = "<leader>$",
	description = "AI",
	mode = "n",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
})
for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "<leader>$" .. bind.key
	bind.mode = bind.mode or "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = false
	table.insert(result, bind)
end

return result
