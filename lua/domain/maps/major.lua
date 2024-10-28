local lsp_controller = require("application.controllers.lsp")
local diagnostic_controller = require("application.controllers.diagnostic")
local searcher_controller = require("application.controllers.searcher")
local rest_controller = require("application.controllers.rest")
local noter_controller = require("application.controllers.noter")
local formatter_controller = require("application.controllers.formatter")
local database_controller = require("application.controllers.database")
local screenshot_controller = require("application.controllers.screenshot")
local hover_controller = require("application.controllers.hover")
local outline_controller = require("application.controllers.outline")
local pomodoro_controller = require("application.controllers.pomodoro")
local tester_controller = require("application.controllers.tester")
local notebook_controller = require("application.controllers.notebook")

---@type KeyBind[]
local test_content = {
	{ key = "t", description = "Test" },
	{ key = "tb", description = "[b]buffer", method = tester_controller.run() },
	{ key = "tT", description = "[T]oggle", method = tester_controller.toggle() },
}

---@type KeyBind[]
local format_content = {
	{ key = "=", description = "Format" },
	{ key = "==", description = "[=] Buffer", method = formatter_controller.format() },
}

---@type KeyBind[]
local database_content = {
	{ key = "b", description = "database" },
	{ key = "bc", description = "[c] Open", method = database_controller.open() },
	{ key = "bd", description = "Lsp in[f]o", method = lsp_controller.info() },
	{ key = "br", description = "Lsp [r]estart", method = lsp_controller.restart() },
}

---@type KeyBind[]
local capture_content = {
	{ key = "C", description = "Capture" },
	{ key = "Cp", description = "Start [p]omodoro", method = pomodoro_controller.start() },
}

---@type KeyBind[]
local notebook_content = {
	{ key = ".", description = "Notebook", method = notebook_controller.activate_transient() },
}

---@type KeyBind[]
local jumpto_content = {
	{ key = "G", description = "Jumpto" },
	{ key = "Gd", description = "[d]definition", method = lsp_controller.navigate({ type = "definition", options = { type = "remote" } }) },
	{ key = "Gi", description = "[i]mplementation", method = lsp_controller.navigate({ type = "implementation", options = { type = "remote" } }) },
	{ key = "Gk", description = "Documentation ([k])", method = lsp_controller.show_documentation() },
	{ key = "GK", description = "Signature ([K])", method = lsp_controller.show_signature() },
	{ key = "Gr", description = "[r]eferences", method = lsp_controller.navigate({ type = "references", options = { type = "remote" } }) },
	{ key = "Gs", description = "Get [s]symbol", method = lsp_controller.get_symbol() },
	{ key = "GS", description = "Outline toggle ([S])", method = outline_controller.toggle() },
	{ key = "Gt", description = "[t]ype-definition", method = lsp_controller.navigate({ type = "typedefinition", options = { type = "remote" } }) },
}

---@type KeyBind[]
local goto_content = {
	{ key = "g", description = "Goto" },
	{ key = "gd", description = "[d]definition", method = lsp_controller.navigate({ type = "definition" }) },
	{ key = "gi", description = "[i]mplementation", method = lsp_controller.navigate({ type = "implementation" }) },
	{ key = "gk", description = "Documentation ([k])", method = lsp_controller.show_documentation() },
	{ key = "gK", description = "Signature ([K])", method = lsp_controller.show_signature() },
	{ key = "gr", description = "[r]eferences", method = lsp_controller.navigate({ type = "references" }) },
	{ key = "gt", description = "[t]ype-definition", method = lsp_controller.navigate({ type = "typedefinition" }) },
}

---@type KeyBind[]
local help_content = {
	{ key = "h", description = "Help" },
	{ key = "hh", description = "Show [h]over", method = hover_controller.toggle() },
	{ key = "hH", description = "Show signature ([H])", method = lsp_controller.show_signature() },
}

---@type KeyBind[]
local insert_content = {
	{ key = "i", mode = { "n", "x" }, description = "Insert" },
	{
		key = "iDh",
		mode = "x",
		description = "Take [h]ighlight",
		method = screenshot_controller.capture({ action = "copy", type = "select" }),
	},
	{
		key = "iDH",
		mode = "x",
		description = "Save [H]ighlight",
		method = screenshot_controller.capture({ action = "save", type = "select" }),
	},
	{
		key = "iDs",
		mode = "x",
		description = "Take [s]screenshot",
		method = screenshot_controller.capture({ action = "copy" }),
	},
	{
		key = "iDS",
		mode = "x",
		description = "Save [S]screenshot",
		method = screenshot_controller.capture({ action = "save" }),
	},
	{
		key = "iDt",
		mode = "x",
		description = "[t]ext screenshot",
		method = screenshot_controller.capture({ action = "copy", type = "text" }),
	},
	{ key = "iH", description = "[H]eading", method = noter_controller.insert_heading() },
	{ key = "in", description = "[n]ew note", method = noter_controller.new() },
}

---@type KeyBind[]
local refact_content = {
	{ key = "r", description = "Refact" },
	{ key = "rr", description = "[r]ename", method = lsp_controller.rename() },
	{ key = "rq", description = "[q]uickfix", method = diagnostic_controller.loclist() },
}

---@type KeyBind[]
local toggle_content = {
	{ key = "T", description = "Toggle" },
	{ key = "Tc", description = "Toggle [c]heckbox", method = noter_controller.toggle_checkbox() },
	{ key = "TT", description = "Cycle state ([T])", method = noter_controller.todo_next_state() },
}

---@type KeyBind[]
local major_content = {
	{ key = "a", description = "Code [a]ction", method = lsp_controller.show_code_action() },
	{ key = "N", description = "Previous li[n]k", method = searcher_controller.search_link_next() },
	{ key = "P", description = "Next link ([P])", method = searcher_controller.search_link_previous() },
	{ key = "j", description = "Open (http [j]ump)", method = rest_controller.open() },
	{ key = "s", description = "[s]end", method = rest_controller.send() },
	{ key = "R", description = "[R]eplay", method = rest_controller.replay() },
}

local result = {}
local contents = {}
for _, content in pairs({
	format_content,
	database_content,
	goto_content,
	jumpto_content,
	help_content,
	insert_content,
	refact_content,
	toggle_content,
	major_content,
	test_content,
	capture_content,
	notebook_content,
}) do
	for _, bind in pairs(content) do
		table.insert(contents, bind)
	end
end

table.insert(result, {
	key = "<leader>m",
	description = "Major",
	mode = { "n", "v" },
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
})

for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "<leader>m" .. bind.key
	bind.mode = bind.mode or "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = false
	table.insert(result, bind)
end

return result
