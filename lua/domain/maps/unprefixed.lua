local documentation_use_case = require("application.use_cases.lsp")

local unprefixed_content = {
	{ key = "<M-j>", description = "Drag line down", method = ":m .+1==<CR>" },
	{ key = "<M-k>", description = "Drag line up", method = ":m .-2==<CR>" },
	{ key = "<M-j>", mode = "v", description = "Drag line down", method = ":m '>+1<CR>gv=gv" },
	{ key = "<M-k>", mode = "v", description = "Drag line up", method = ":m '<-2<CR>gv=gv" },
	{ key = "<M-j>", mode = "i", description = "Drag line down", method = "<Esc>:m .+1<CR>==gi" },
	{ key = "<M-k>", mode = "i", description = "Drag line up", method = "<Esc>:m .-2<CR>==gi" },
	{ key = "<C-BS>", mode = { "i", "c" }, description = "Delete previous word", method = "<C-w>" },
	{ key = "<C-H>", mode = { "i", "c" }, description = "Delete previous word", method = "<C-w>" },
}

local result = {}
local contents = {}
for _, content in pairs({
	unprefixed_content,
}) do
	for _, bind in pairs(content) do
		table.insert(contents, bind)
	end
end

for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = content.key
	bind.prefix = ""
	bind.mode = content.mode or "n"
	bind.description = content.description or ""
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = false
	table.insert(result, bind)
end

return result
