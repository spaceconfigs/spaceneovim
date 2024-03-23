local use_case = require("application.use_cases.chatbot")

local output_content = {
	{ key = "o", description = "Output" },
	{ key = "og", description = "Toggle", method = use_case.toggle },
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
	nowait = true,
})
for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "<leader>$" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = true
	table.insert(result, bind)
end

return result
