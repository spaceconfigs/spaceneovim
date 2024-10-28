local clone = require("domain.utils.table").clone
---@param controllers ControllerRegistry
---@return KeyBind[]
return function(controllers)
	---@type KeyBind[]
	local debugger_content = {
		{ key = ".", description = "UI", method = controllers.debugger.open() },
		{ key = "_", description = "REPL", method = controllers.debugger.repl_toggle() },
		{ key = "A", description = "Abandon all process", method = controllers.debugger.close() },
		{ key = "c", description = "Continue", method = controllers.debugger.continue() },
		{ key = "i", description = "Step in", method = controllers.debugger.step({ type = "into" }) },
		{ key = "o", description = "Step out", method = controllers.debugger.step({ type = "out" }) },
		{ key = "s", description = "Step over", method = controllers.debugger.step({ type = "over" }) },
		-- { key = "u", description = "Go up", method = controllers.debugger.step({ type = "back" }) },
		{ key = "m", description = "Run to cursor", method = controllers.debugger.run_to_cursor() },
		{ key = "r", description = "Restart frame", method = controllers.debugger.restart_frame() },
		{ key = "v", description = "Hover", method = controllers.debugger.hover() },
		{ key = "p", description = "Preview", method = controllers.debugger.preview() },
	}

	---@type KeyBind[]
	local breakpoint_content = {
		{ key = "b", description = "Breakpoints" },
		{ key = "bb", description = "Toggle", method = controllers.debugger.toggle_breakpoint() },
		{ key = "bc", description = "Set condiction", method = controllers.debugger.set_breakpoint() },
		{ key = "bD", description = "Clean all", method = controllers.debugger.clear_breakpoints() },
		{ key = "bE", description = "Set exceptions", method = controllers.debugger.set_exception_breakpoints() },
	}

	---@type KeyBind[]
	local start_stop_content = {
		{ key = "d", description = "Debugging" },
		{ key = "dd", description = "Start", method = controllers.debugger.continue() },
		{ key = "dl", description = "Last configuration", method = controllers.debugger.run_last() },
	}

	---@type KeyBind[]
	local context_content = {
		{ key = "S", description = "Context" },
		{ key = "Sd", description = "Go down in stacktrace", method = controllers.debugger.go({ direction = "down" }) },
		{ key = "Su", description = "Go up in stacktrace", method = controllers.debugger.go({ direction = "up" }) },
	}

	---@type KeyBind[]
	local window_content = {
		{ key = "w", description = "Window" },
		{ key = "wb", description = "List breakpoints", method = controllers.debugger.list_breakpoints() },
		{ key = "wl", description = "List variables", method = controllers.debugger.list_variables() },
	}

	local result = {}
	local contents = {}
	for _, content in pairs({
		debugger_content,
		breakpoint_content,
		start_stop_content,
		context_content,
		window_content,
	}) do
		for _, bind in pairs(content) do
			table.insert(contents, bind)
		end
	end

	table.insert(result, {
		key = "<leader>d",
		description = "Debugger",
		mode = "n",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
	})
	for _, content in pairs(contents) do
		local bind = clone(content)
		bind.key = "<leader>d" .. bind.key
		bind.mode = "n"
		bind.buffer = nil
		bind.silent = true
		bind.noremap = true
		bind.nowait = false
		table.insert(result, bind)
	end

	return result
end
