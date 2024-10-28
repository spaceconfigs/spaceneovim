local clone = require("domain.utils.table").clone
---@param controllers ControllerRegistry
---@return KeyBind[]
return function(controllers)
	---@type KeyBind[]
	local test_content = {
		{ key = "t", description = "Test" },
		{ key = "tb", description = "[b]buffer", method = controllers.tester.run() },
		{ key = "tT", description = "[T]oggle", method = controllers.tester.toggle() },
	}

	---@type KeyBind[]
	local format_content = {
		{ key = "=", description = "Format" },
		{ key = "==", description = "[=] Buffer", method = controllers.formatter.format() },
	}

	---@type KeyBind[]
	local database_content = {
		{ key = "b", description = "database" },
		{ key = "bc", description = "[c] Open", method = controllers.database.open() },
		{ key = "bd", description = "Lsp in[f]o", method = controllers.lsp.info() },
		{ key = "br", description = "Lsp [r]estart", method = controllers.lsp.restart() },
	}

	---@type KeyBind[]
	local capture_content = {
		{ key = "C", description = "Capture" },
		{ key = "Cp", description = "Start [p]omodoro", method = controllers.pomodoro.start() },
	}

	---@type KeyBind[]
	local notebook_content = {
		{ key = ".", description = "Notebook", method = controllers.notebook.activate_transient() },
	}

	---@type KeyBind[]
	local jumpto_content = {
		{ key = "G", description = "Jumpto" },
		{ key = "Gd", description = "[d]definition", method = controllers.lsp.navigate({ type = "definition", options = { type = "remote" } }) },
		{ key = "Gi", description = "[i]mplementation", method = controllers.lsp.navigate({ type = "implementation", options = { type = "remote" } }) },
		{ key = "Gk", description = "Documentation ([k])", method = controllers.lsp.show_documentation() },
		{ key = "GK", description = "Signature ([K])", method = controllers.lsp.show_signature() },
		{ key = "Gr", description = "[r]eferences", method = controllers.lsp.navigate({ type = "references", options = { type = "remote" } }) },
		{ key = "Gs", description = "Get [s]symbol", method = controllers.lsp.get_symbol() },
		{ key = "GS", description = "Outline toggle ([S])", method = controllers.outline.toggle() },
		{ key = "Gt", description = "[t]ype-definition", method = controllers.lsp.navigate({ type = "typedefinition", options = { type = "remote" } }) },
	}

	---@type KeyBind[]
	local goto_content = {
		{ key = "g", description = "Goto" },
		{ key = "gd", description = "[d]definition", method = controllers.lsp.navigate({ type = "definition" }) },
		{ key = "gi", description = "[i]mplementation", method = controllers.lsp.navigate({ type = "implementation" }) },
		{ key = "gk", description = "Documentation ([k])", method = controllers.lsp.show_documentation() },
		{ key = "gK", description = "Signature ([K])", method = controllers.lsp.show_signature() },
		{ key = "gr", description = "[r]eferences", method = controllers.lsp.navigate({ type = "references" }) },
		{ key = "gt", description = "[t]ype-definition", method = controllers.lsp.navigate({ type = "typedefinition" }) },
	}

	---@type KeyBind[]
	local help_content = {
		{ key = "h", description = "Help" },
		{ key = "hh", description = "Show [h]over", method = controllers.hover.toggle() },
		{ key = "hH", description = "Show signature ([H])", method = controllers.lsp.show_signature() },
	}

	---@type KeyBind[]
	local insert_content = {
		{ key = "i", mode = { "n", "x" }, description = "Insert" },
		{
			key = "iDh",
			mode = "x",
			description = "Take [h]ighlight",
			method = controllers.screenshot.capture({ action = "copy", type = "select" }),
		},
		{
			key = "iDH",
			mode = "x",
			description = "Save [H]ighlight",
			method = controllers.screenshot.capture({ action = "save", type = "select" }),
		},
		{
			key = "iDs",
			mode = "x",
			description = "Take [s]screenshot",
			method = controllers.screenshot.capture({ action = "copy" }),
		},
		{
			key = "iDS",
			mode = "x",
			description = "Save [S]screenshot",
			method = controllers.screenshot.capture({ action = "save" }),
		},
		{
			key = "iDt",
			mode = "x",
			description = "[t]ext screenshot",
			method = controllers.screenshot.capture({ action = "copy", type = "text" }),
		},
		{ key = "iH", description = "[H]eading", method = controllers.noter.insert_heading() },
		{ key = "in", description = "[n]ew note", method = controllers.noter.new() },
	}

	---@type KeyBind[]
	local refact_content = {
		{ key = "r", description = "Refact" },
		{ key = "rr", description = "[r]ename", method = controllers.lsp.rename() },
		{ key = "rq", description = "[q]uickfix", method = controllers.diagnostic.loclist() },
	}

	---@type KeyBind[]
	local toggle_content = {
		{ key = "T", description = "Toggle" },
		{ key = "Tc", description = "Toggle [c]heckbox", method = controllers.noter.toggle_checkbox() },
		{ key = "TT", description = "Cycle state ([T])", method = controllers.noter.todo_next_state() },
	}

	---@type KeyBind[]
	local major_content = {
		{ key = "a", description = "Code [a]ction", method = controllers.lsp.show_code_action() },
		{ key = "N", description = "Previous li[n]k", method = controllers.searcher.search_link_next() },
		{ key = "P", description = "Next link ([P])", method = controllers.searcher.search_link_previous() },
		{ key = "j", description = "Open (http [j]ump)", method = controllers.rest.open() },
		{ key = "s", description = "[s]end", method = controllers.rest.send() },
		{ key = "R", description = "[R]eplay", method = controllers.rest.replay() },
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
