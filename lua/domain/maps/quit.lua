local quit_content = {
	{ key = "q", description = "Kill", method = ":confirm qall<cr>" },
	{ key = "s", description = "Save and quit", method = ":wqall<cr>" },
}

local result = {}
local contents = {}
for _, content in pairs({
	quit_content,
}) do
	for _, bind in pairs(content) do
		table.insert(contents, bind)
	end
end

table.insert(result, {
	key = "<leader>q",
	description = "Quit",
	mode = "n",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
})
for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "<leader>q" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = true
	table.insert(result, bind)
end

return result
