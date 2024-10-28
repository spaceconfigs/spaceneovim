---@type DiagnosticContract
local diagnostic_controller = require("application.controllers.diagnostic")

---@type KeyBind[]
local maps = {
	{ key = "l", description = "List", method = diagnostic_controller.toggle() },
	{ key = "n", description = "Next", method = diagnostic_controller.show("next") },
	{ key = "p", description = "Previous", method = diagnostic_controller.show("previous") },
	{ key = "x", description = "Show", method = diagnostic_controller.show() },
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
	nowait = false,
})
for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "<leader>e" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = false
	table.insert(result, bind)
end

return result
