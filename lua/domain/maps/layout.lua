local layout_controller = require("application.controllers.layout")

---@type KeyBind[]
local layout_content = {
	{ key = "<Tab>", description = "Load previous", method = layout_controller.previous() },
	{ key = "D", description = "Delete", method = layout_controller.delete() },
	{ key = "l", description = "List", method = layout_controller.list() },
	{ key = "L", description = "Reload", method = layout_controller.reload() },
	{ key = "s", description = "Save", method = layout_controller.save() },
	{ key = "R", description = "Rename", method = layout_controller.rename() },
}

local result = {}
local contents = {}
for _, content in pairs({
	layout_content,
}) do
	for _, bind in pairs(content) do
		table.insert(contents, bind)
	end
end

table.insert(result, {
	key = "<leader>l",
	description = "Layout",
	mode = "n",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
})
for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "<leader>l" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = false
	table.insert(result, bind)
end

return result
