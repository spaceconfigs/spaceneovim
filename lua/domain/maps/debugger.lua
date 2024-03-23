local debugger_use_case = require("application.use_cases.debugger")

local debugger_content = {
	{ key = ".", description = "UI", method = debugger_use_case.open },
	{ key = "_", description = "REPL", method = debugger_use_case.repl_toggle },
	{ key = "A", description = "Abandon all process", method = debugger_use_case.close },
	{ key = "c", description = "Continue", method = debugger_use_case.continue },
	{ key = "i", description = "Step in", method = debugger_use_case.step_into },
	{ key = "o", description = "Step out", method = debugger_use_case.step_out },
	{ key = "s", description = "Step over", method = debugger_use_case.step_over },
	-- { key = "u", description = "Go up", method = debugger_use_case.step_back },
	{ key = "m", description = "Run to cursor", method = debugger_use_case.run_to_cursor },
	{ key = "r", description = "Restart frame", method = debugger_use_case.restart_frame },
	{ key = "v", description = "Hover", method = debugger_use_case.hover },
	{ key = "p", description = "Preview", method = debugger_use_case.preview },
}

local breakpoint_content = {
	{ key = "b", description = "Breakpoints" },
	{ key = "bb", description = "Toggle", method = debugger_use_case.toggle_breakpoint },
	{ key = "bc", description = "Set condiction", method = debugger_use_case.set_breakpoint },
	{ key = "bD", description = "Clean all", method = debugger_use_case.clear_breakpoints },
	{ key = "bE", description = "Set exceptions", method = debugger_use_case.set_exception_breakpoints },
}

local start_stop_content = {
	{ key = "d", description = "Debugging" },
	{ key = "dd", description = "Start", method = debugger_use_case.continue },
	{ key = "dl", description = "Last configuration", method = debugger_use_case.run_last },
}

local context_content = {
	{ key = "S", description = "Context" },
	{ key = "Sd", description = "Go down in stacktrace", method = debugger_use_case.go_down },
	{ key = "Su", description = "Go up in stacktrace", method = debugger_use_case.go_up },
}

local window_content = {
	{ key = "w", description = "Window" },
	{ key = "wb", description = "List breakpoints", method = debugger_use_case.list_breakpoints },
	{ key = "wl", description = "List variables", method = debugger_use_case.list_variables },
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
	nowait = true,
})
for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "<leader>d" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = true
	table.insert(result, bind)
end

return result
