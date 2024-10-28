local buffer_controller = require("application.controllers.buffer")

---@type KeyBind[]
local buffer_content = {
	{ key = "<C-d>", description = "Close others ([d]elete)", method = buffer_controller.close_others() },
	{ key = "b", description = "Find ([b]uffer)", method = buffer_controller.list() },
	{ key = "d", description = "Close ([d]elete)", method = buffer_controller.delete() },
	{ key = "n", description = "[n]ext", method = buffer_controller.next() },
	{ key = "m", description = "[m]essage buffer", method = buffer_controller.messages() },
	{ key = "p", description = "[p]revious", method = buffer_controller.previous() },
	{ key = "u", description = "Reopen ([u]ndo)", method = buffer_controller.reopen() },
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
	nowait = false,
})
for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "<leader>b" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = false
	table.insert(result, bind)
end

return result
