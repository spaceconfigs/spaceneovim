local debugger_use_case = require("application.use_cases.debugger")

local key_bindings = {
	-- { key = "bb", action = debugger_use_case.toggle_breakpoint },
	-- { key = "bc", action = debugger_use_case.clear_breakpoints },
	-- { key = "bC", action = debugger_use_case.set_breakpoint },
	{ key = "c", action = debugger_use_case.continue },
	{ key = "i", action = debugger_use_case.step_into },
	{ key = "J", action = debugger_use_case.run_to_cursor },
	{ key = "o", action = debugger_use_case.step_out },
	{ key = "d", action = debugger_use_case.go_down },
	{ key = "u", action = debugger_use_case.go_up },
	-- { key = "A", action = debugger_use_case.close },
	{ key = "r", action = debugger_use_case.restart_frame },
	{ key = "s", action = debugger_use_case.step_over },
	{ key = "v", action = debugger_use_case.hover },
	{ key = "p", action = "" }, -- Not sure what action to bind to "p"
}

local function create_keymaps(set, opts)
	for _, binding in ipairs(key_bindings) do
		set("n", binding.key, binding.action, opts)
	end
end

local function delete_keymaps(del)
	for _, binding in ipairs(key_bindings) do
		del("n", binding.key)
	end
end

vim.api.nvim_create_autocmd("User", {
	pattern = "DapStopped",
	callback = function()
		local opts = { noremap = true, silent = true }
		create_keymaps(vim.keymap.set, opts)
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = { "DapTerminated", "DapExited" },
	callback = function()
		delete_keymaps(vim.api.nvim_del_keymap)
	end,
})
