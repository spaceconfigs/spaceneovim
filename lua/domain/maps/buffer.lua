local session_use_case = require("application.use_cases.session")
local buffer_use_case = require("application.use_cases.buffer")

local buffer_content = {
	{ key = "<C-c>", description = "Close others", method = buffer_use_case.close_others },
	{ key = "a", description = "Save session", method = session_use_case.save },
	{ key = "b", description = "Find", method = buffer_use_case.list },
	{ key = "d", description = "Close", method = buffer_use_case.delete },
	{ key = "i", description = "Document Symbols", method = buffer_use_case.lsp_symbols },
	{ key = "l", description = "List persp buffers", method = buffer_use_case.list_persp },
	{ key = "n", description = "Next", method = buffer_use_case.next },
	{ key = "m", description = "Message buffer", method = buffer_use_case.messages },
	{ key = "p", description = "Previous", method = buffer_use_case.previous },
	{ key = "r", description = "Delete session", method = session_use_case.delete },
	{ key = "u", description = "Reopen", method = buffer_use_case.reopen },
}

local result = {}
local contents = {}
for _, content in pairs({
	buffer_content,
}) do
	for _, bind in pairs(content) do
		table.insert(contents, bind)
	end
end

table.insert(result, {
	key = "<leader>b",
	description = "Buffer",
	mode = "n",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
})
for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "<leader>b" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = true
	table.insert(result, bind)
end

return result
