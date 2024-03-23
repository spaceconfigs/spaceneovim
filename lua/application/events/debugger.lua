local debugger_use_case = require("application.use_cases.debugger")

vim.api.nvim_create_autocmd("User", {
	pattern = "DapStopped",
	callback = function()
		local opts = { noremap = true, silent = true }
		local keymap_set = vim.keymap.set

		keymap_set("n", "bb", debugger_use_case.toggle_breakpoint, opts)
		keymap_set("n", "bc", debugger_use_case.clear_breakpoints, opts)
		keymap_set("n", "bC", debugger_use_case.set_breakpoint, opts)
		keymap_set("n", "c", debugger_use_case.continue, opts)
		keymap_set("n", "i", debugger_use_case.step_into, opts)
		keymap_set("n", "J", debugger_use_case.run_to_cursor, opts)
		keymap_set("n", "o", debugger_use_case.step_out, opts)
		keymap_set("n", "d", debugger_use_case.go_down, opts)
		keymap_set("n", "u", debugger_use_case.go_up, opts)
		keymap_set("n", "q", debugger_use_case.close, opts)
		keymap_set("n", "r", debugger_use_case.restart_frame, opts)
		keymap_set("n", "s", debugger_use_case.step_over, opts)
    keymap_set("n", "v", debugger_use_case.hover, opts)
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = { "DapTerminated", "DapExited" },
	callback = function()
		local keymap_del = vim.api.nvim_del_keymap

		keymap_del("n", "bb")
		keymap_del("n", "bc")
		keymap_del("n", "bC")
		keymap_del("n", "c")
		keymap_del("n", "i")
		keymap_del("n", "o")
		keymap_del("n", "u")
		keymap_del("n", "d")
		keymap_del("n", "q")
		keymap_del("n", "s")
		keymap_del("n", "r")
		keymap_del("n", "J")
		keymap_del("n", "v")
	end,
})
