local lsp_use_case = require("application.use_cases.lsp")
local diagnostic_use_case = require("application.use_cases.diagnostic")
local searcher_use_case = require("application.use_cases.searcher")
local rest_use_case = require("application.use_cases.rest")
local noter_use_case = require("application.use_cases.noter")
local formatter_use_case = require("application.use_cases.formatter")
local database_use_case = require("application.use_cases.database")
local screenshot_use_case = require("application.use_cases.screenshot")
local hover_use_case = require("application.use_cases.hover")
local outline_use_case = require("application.use_cases.outline")
local pomodoro_use_case = require("application.use_cases.pomodoro")
local tester_use_case = require("application.use_cases.tester")
local notebook_use_case = require("application.use_cases.notebook")

local test_content = {
	{ key = "t", description = "Test" },
	{ key = "tb", description = "[b]buffer", method = tester_use_case.run() },
	{ key = "tT", description = "[T]oggle", method = tester_use_case.toggle() },
}

local format_content = {
	{ key = "=", description = "Format" },
	{ key = "==", description = "[=] Buffer", method = formatter_use_case.format },
}

local database_content = {
	{ key = "b", description = "database" },
	{ key = "bc", description = "[c] Open", method = database_use_case.open },
	{ key = "bd", description = "Lsp in[f]o", method = lsp_use_case.info },
	{ key = "br", description = "Lsp [r]estart", method = lsp_use_case.restart() },
}

local capture_content = {
	{ key = "C", description = "Capture" },
	{ key = "Cp", description = "Start [p]omodoro", method = pomodoro_use_case.start },
}

local notebook_content = {
	{ key = ".", description = "Notebook", method = notebook_use_case.activate_transient },
}

local jumpto_content = {
	{ key = "G", description = "Jumpto" },
	{ key = "Gd", description = "[d]definition", method = lsp_use_case.definition({ type = "remote" }) },
	{ key = "Gi", description = "[i]mplementation", method = lsp_use_case.implementation({ type = "remote" }) },
	{ key = "Gk", description = "Documentation ([k])", method = lsp_use_case.show_documentation },
	{ key = "GK", description = "Signature ([K])", method = lsp_use_case.show_signature },
	{ key = "Gr", description = "[r]eferences", method = lsp_use_case.references({ type = "remote" }) },
	{ key = "Gs", description = "Get [s]symbol", method = lsp_use_case.get_symbol },
	{ key = "GS", description = "Outline toggle ([S])", method = outline_use_case.toggle },
	{ key = "Gt", description = "[t]ype-definition", method = lsp_use_case.typedefinition({ type = "remote" }) },
}

local goto_content = {
	{ key = "g", description = "Goto" },
	{ key = "gd", description = "[d]definition", method = lsp_use_case.definition() },
	{ key = "gi", description = "[i]mplementation", method = lsp_use_case.implementation() },
	{ key = "gk", description = "Documentation ([k])", method = lsp_use_case.show_documentation },
	{ key = "gK", description = "Signature ([K])", method = lsp_use_case.show_signature },
	{ key = "gr", description = "[r]eferences", method = lsp_use_case.references() },
	{ key = "gt", description = "[t]ype-definition", method = lsp_use_case.typedefinition() },
}

local help_content = {
	{ key = "h", description = "Help" },
	{ key = "hh", description = "Show [h]over", method = hover_use_case.toggle },
	{ key = "hH", description = "Show signature ([H])", method = lsp_use_case.signature_help() },
}

local insert_content = {
	{ key = "i", mode = { "n", "x" }, description = "Insert" },
	{
		key = "iDh",
		mode = "x",
		description = "Take [h]ighlight",
		method = screenshot_use_case.copy({ type = "select" }),
	},
	{
		key = "iDH",
		mode = "x",
		description = "Save [H]ighlight",
		method = screenshot_use_case.save({ type = "select" }),
	},
	{
		key = "iDs",
		mode = "x",
		description = "Take [s]screenshot",
		method = screenshot_use_case.copy(),
	},
	{
		key = "iDS",
		mode = "x",
		description = "Save [S]screenshot",
		method = screenshot_use_case.save(),
	},
	{
		key = "iDt",
		mode = "x",
		description = "[t]ext screenshot",
		method = screenshot_use_case.copy({ type = "text" }),
	},
	{ key = "iH", description = "[H]eading", method = noter_use_case.insert_heading },
	{ key = "in", description = "[n]ew note", method = noter_use_case.new },
}

local refact_content = {
	{ key = "r", description = "Refact" },
	{ key = "rr", description = "[r]ename", method = lsp_use_case.rename() },
	{ key = "rq", description = "[q]uickfix", method = diagnostic_use_case.loclist() },
}

local toggle_content = {
	{ key = "T", description = "Toggle" },
	{ key = "Tc", description = "Toggle [c]heckbox", method = noter_use_case.toggle_checkbox },
	{ key = "TT", description = "Cycle state ([T])", method = noter_use_case.todo_next_state },
}

local major_content = {
	{ key = "a", description = "Code [a]ction", method = lsp_use_case.code_action() },
	{ key = "N", description = "Previous li[n]k", method = searcher_use_case.search_link_next() },
	{ key = "P", description = "Next link ([P])", method = searcher_use_case.search_link_previous() },
	{ key = "j", description = "Open (http [j]ump)", method = rest_use_case.open },
	{ key = "s", description = "[s]end", method = rest_use_case.send },
	{ key = "R", description = "[R]eplay", method = rest_use_case.replay },
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
