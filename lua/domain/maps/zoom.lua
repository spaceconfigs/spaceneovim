local fold_controller = require("application.controllers.fold")
local zoom_controller = require("application.controllers.zoom")

---@type KeyBind[]
local fold_content = {
	{ key = ".", description = "Fold" },
	{ key = ".a", description = "Toggle", method = fold_controller.fold({ action = "toggle", location = "cursor" }) },
	{ key = ".c", description = "Close", method = fold_controller.fold({ action = "close", location = "cursor" }) },
	{ key = ".o", description = "Open", method = fold_controller.fold({ action = "open", location = "cursor" }) },
	{ key = ".m", description = "Close All", method = fold_controller.fold({ action = "close", location = "all" }) },
	{ key = ".r", description = "Open All", method = fold_controller.fold({ action = "open", location = "all" }) },
}

---@type KeyBind[]
local frame_content = {
	{ key = "f", description = "Zoom frame" },
	{ key = "f+", description = "In", method = zoom_controller.change({ delta = 1 }) },
	{ key = "f-", description = "Out", method = zoom_controller.change({ delta = -1 }) },
}
local result = {}
local contents = {}

for _, content in pairs({
	fold_content,
	frame_content,
}) do
	for _, bind in pairs(content) do
		table.insert(contents, bind)
	end
end

table.insert(result, {
	key = "<leader>z",
	description = "Zoom",
	mode = "n",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
})

for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "<leader>z" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = false
	table.insert(result, bind)
end

return result
