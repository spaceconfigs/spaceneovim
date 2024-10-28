local clone = require("domain.utils.table").clone
local database = require("domain.contracts.controller_registry").database()
local diagnostic = require("domain.contracts.controller_registry").diagnostic()
local formatter = require("domain.contracts.controller_registry").formatter()
local hover = require("domain.contracts.controller_registry").hover()
local lsp = require("domain.contracts.controller_registry").lsp()
local notebook = require("domain.contracts.controller_registry").notebook()
local noter = require("domain.contracts.controller_registry").noter()
local outline = require("domain.contracts.controller_registry").outline()
local pomodoro = require("domain.contracts.controller_registry").pomodoro()
local rest = require("domain.contracts.controller_registry").rest()
local screenshot = require("domain.contracts.controller_registry").screenshot()
local searcher = require("domain.contracts.controller_registry").searcher()
local tester = require("domain.contracts.controller_registry").tester()
---@return KeyBind[]
return function()
	---@type KeyBind[]
	local test_content = {
		{ key = "t", description = "Test" },
		{ key = "tb", description = "Buffer", method = tester.run() },
		{ key = "tT", description = "Toggle", method = tester.toggle() },
	}

	---@type KeyBind[]
	local format_content = {
		{ key = "=", description = "Format" },
		{ key = "==", description = "Buffer", method = formatter.format() },
	}

	---@type KeyBind[]
	local database_content = {
		{ key = "b", description = "Database" },
		{ key = "bc", description = "Open", method = database.open() },
		{ key = "bd", description = "Lsp info", method = lsp.info() },
		{ key = "br", description = "Lsp restart", method = lsp.restart() },
	}

	---@type KeyBind[]
	local capture_content = {
		{ key = "C", description = "Capture" },
		{ key = "Cp", description = "Start pomodoro", method = pomodoro.start() },
	}

	---@type KeyBind[]
	local notebook_content = {
		{ key = ".", description = "Notebook", method = notebook.activate_transient() },
	}

	---@type KeyBind[]
	local jumpto_content = {
		{ key = "G", description = "Jumpto" },
		{ key = "Gd", description = "Definition", method = lsp.navigate({ type = "definition", options = { type = "remote" } }) },
		{ key = "Gi", description = "Implementation", method = lsp.navigate({ type = "implementation", options = { type = "remote" } }) },
		{ key = "Gk", description = "Documentation", method = lsp.show_documentation() },
		{ key = "GK", description = "Signature", method = lsp.show_signature() },
		{ key = "Gr", description = "References", method = lsp.navigate({ type = "references", options = { type = "remote" } }) },
		{ key = "Gs", description = "Get symbol", method = lsp.get_symbol() },
		{ key = "GS", description = "Outline toggle", method = outline.toggle() },
		{ key = "Gt", description = "Type-definition", method = lsp.navigate({ type = "typedefinition", options = { type = "remote" } }) },
	}

	---@type KeyBind[]
	local goto_content = {
		{ key = "g", description = "Goto" },
		{ key = "gd", description = "Definition", method = lsp.navigate({ type = "definition" }) },
		{ key = "gi", description = "Implementation", method = lsp.navigate({ type = "implementation" }) },
		{ key = "gk", description = "Documentation", method = lsp.show_documentation() },
		{ key = "gK", description = "Signature", method = lsp.show_signature() },
		{ key = "gr", description = "References", method = lsp.navigate({ type = "references" }) },
		{ key = "gt", description = "Type-definition", method = lsp.navigate({ type = "typedefinition" }) },
	}

	---@type KeyBind[]
	local help_content = {
		{ key = "h", description = "Help" },
		{ key = "hh", description = "Show hover", method = hover.toggle() },
		{ key = "hH", description = "Show signature", method = lsp.show_signature() },
	}

	---@type KeyBind[]
	local insert_content = {
		{ key = "i", mode = { "n", "x" }, description = "Insert" },
		{
			key = "iDh",
			mode = "x",
			description = "Take highlight",
			method = screenshot.capture({ action = "copy", type = "select" }),
		},
		{
			key = "iDH",
			mode = "x",
			description = "Save highlight",
			method = screenshot.capture({ action = "save", type = "select" }),
		},
		{
			key = "iDs",
			mode = "x",
			description = "Take screenshot",
			method = screenshot.capture({ action = "copy" }),
		},
		{
			key = "iDS",
			mode = "x",
			description = "Save screenshot",
			method = screenshot.capture({ action = "save" }),
		},
		{
			key = "iDt",
			mode = "x",
			description = "Text screenshot",
			method = screenshot.capture({ action = "copy", type = "text" }),
		},
		{ key = "iH", description = "Heading", method = noter.insert_heading() },
		{ key = "in", description = "New note", method = noter.new() },
	}

	---@type KeyBind[]
	local refact_content = {
		{ key = "r", description = "Refact" },
		{ key = "rr", description = "Rename", method = lsp.rename() },
		{ key = "rq", description = "Quickfix", method = diagnostic.loclist() },
	}

	---@type KeyBind[]
	local toggle_content = {
		{ key = "T", description = "Toggle" },
		{ key = "Tc", description = "Toggle checkbox", method = noter.toggle_checkbox() },
		{ key = "TT", description = "Cycle state", method = noter.todo_next_state() },
	}

	---@type KeyBind[]
	local major_content = {
		{ key = "a", description = "Code action", method = lsp.show_code_action() },
		{ key = "N", description = "Previous link", method = searcher.search_link_next() },
		{ key = "P", description = "Next link", method = searcher.search_link_previous() },
		{ key = "j", description = "Open (http jump)", method = rest.open() },
		{ key = "s", description = "Send", method = rest.send() },
		{ key = "R", description = "Replay", method = rest.replay() },
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
		local bind = clone(content)
		bind.key = "<leader>m" .. bind.key
		bind.mode = bind.mode or "n"
		bind.buffer = nil
		bind.silent = true
		bind.noremap = true
		bind.nowait = false
		table.insert(result, bind)
	end

	return result
end
