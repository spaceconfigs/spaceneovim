---@type DebuggerContract
local debugger_controller = require("application.controllers.debugger")

---@type KeyBind[]
local debugger_content = {
	{ key = ".", description = "UI", method = debugger_controller.open() },
	{ key = "_", description = "REPL", method = debugger_controller.repl_toggle() },
	{ key = "A", description = "Abandon all process", method = debugger_controller.close() },
	{ key = "c", description = "Continue", method = debugger_controller.continue() },
	{ key = "i", description = "Step in", method = debugger_controller.step({ type = "into" }) },
	{ key = "o", description = "Step out", method = debugger_controller.step({ type = "out" }) },
	{ key = "s", description = "Step over", method = debugger_controller.step({ type = "over" }) },
	-- { key = "u", description = "Go up", method = debugger_controller.step({ type = "back" }) },
	{ key = "m", description = "Run to cursor", method = debugger_controller.run_to_cursor() },
	{ key = "r", description = "Restart frame", method = debugger_controller.restart_frame() },
	{ key = "v", description = "Hover", method = debugger_controller.hover() },
	{ key = "p", description = "Preview", method = debugger_controller.preview() },
}

---@type KeyBind[]
local breakpoint_content = {
	{ key = "b", description = "Breakpoints" },
	{ key = "bb", description = "Toggle", method = debugger_controller.toggle_breakpoint() },
	{ key = "bc", description = "Set condiction", method = debugger_controller.set_breakpoint() },
	{ key = "bD", description = "Clean all", method = debugger_controller.clear_breakpoints() },
	{ key = "bE", description = "Set exceptions", method = debugger_controller.set_exception_breakpoints() },
}

---@type KeyBind[]
local start_stop_content = {
	{ key = "d", description = "Debugging" },
	{ key = "dd", description = "Start", method = debugger_controller.continue() },
	{ key = "dl", description = "Last configuration", method = debugger_controller.run_last() },
}

---@type KeyBind[]
local context_content = {
	{ key = "S", description = "Context" },
	{ key = "Sd", description = "Go down in stacktrace", method = debugger_controller.go({ direction = "down" }) },
	{ key = "Su", description = "Go up in stacktrace", method = debugger_controller.go({ direction = "up" }) },
}

---@type KeyBind[]
local window_content = {
	{ key = "w", description = "Window" },
	{ key = "wb", description = "List breakpoints", method = debugger_controller.list_breakpoints() },
	{ key = "wl", description = "List variables", method = debugger_controller.list_variables() },
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
	local bind = vim.deepcopy(content)
	bind.key = "<leader>d" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = false
	table.insert(result, bind)
end

return result
