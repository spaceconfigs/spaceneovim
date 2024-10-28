local completer_use_case = require("application.use_cases.completer")
local hover_use_case = require("application.use_cases.hover")
local jumper_use_case = require("application.use_cases.jumper")
local editor_use_case = require("application.use_cases.editor")

local unprefixed_content = {
	{ key = "<S-k>", description = "Hover", method = hover_use_case.toggle },
	{
		key = "<C-Space>",
		mode = { "i", "c" },
		description = "Complete",
		method = completer_use_case.complete,
	},
	{ key = "<M-j>", description = "Drag line down", method = editor_use_case.drag_down({ mode = "normal" }) },
	{ key = "<M-k>", description = "Drag line up", method = editor_use_case.drag_up({ mode = "normal" }) },
	{ key = "{", mode = { "n", "v" }, description = "Next paragraph", method = editor_use_case.next_paragraph() },
	{ key = "}", mode = { "n", "v" }, description = "Previous paragraph", method = editor_use_case.previous_paragraph() },
	{ key = "p", mode = { "v" }, description = "Past", method = editor_use_case.paste_before() },
	{ key = "P", mode = { "v" }, description = "Past", method = editor_use_case.paste_after() },
	{
		key = "<M-j>",
		mode = "v",
		description = "Drag line down",
		method = editor_use_case.drag_down({ mode = "visual" }),
	},
	{
		key = "<M-k>",
		mode = "v",
		description = "Drag line up",
		method = editor_use_case.drag_up({ mode = "visual" }),
	},
	{
		key = "<M-j>",
		mode = "i",
		description = "Drag line down",
		method = editor_use_case.drag_down({ mode = "insert" }),
	},
	{
		key = "<M-k>",
		mode = "i",
		description = "Drag line up",
		method = editor_use_case.drag_up({ mode = "insert" }),
	},
	{
		key = "<Esc>",
		mode = "t",
		description = "Go to normal mode",
		method = editor_use_case.terminal_escape(),
	},
	{ key = "<C-BS>", mode = { "i", "c" }, description = "Delete previous word", method = editor_use_case.delete_word() },
	{ key = "<C-H>", mode = { "i", "c" }, description = "Delete previous word", method = editor_use_case.delete_word() },
	{
		key = "r",
		mode = { "o" },
		description = "Remote jump",
		method = jumper_use_case.remote(),
	},
	{ key = "q", mode = { "n" }, description = "", method = editor_use_case.noop() },
}

vim.keymap.set("n", "k", function()
	return (vim.v.count > 0 and "m'" .. vim.v.count or "") .. "k"
end, { expr = true, silent = true })

vim.keymap.set("n", "j", function()
	return (vim.v.count > 0 and "m'" .. vim.v.count or "") .. "j"
end, { expr = true, silent = true })

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
