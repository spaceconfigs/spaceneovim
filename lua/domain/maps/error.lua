local buffer_use_case = require("application.use_cases.buffer")

local maps = {
	{ key = "l", description = "Buffer Diagnostics", method = buffer_use_case.diagnostics },
	{ key = "n", description = "Next Diagnostic", method = vim.diagnostic.goto_next },
	{ key = "p", description = "Prev Diagnostic", method = vim.diagnostic.goto_prev },
}

local result = {}
local contents = {}
for _, content in pairs({
	maps,
}) do
	for _, bind in pairs(content) do
		table.insert(contents, bind)
	end
end

table.insert(result, {
	key = "<leader>e",
	description = "Error",
	mode = "n",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
})
for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "<leader>e" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = true
	table.insert(result, bind)
end

return result
