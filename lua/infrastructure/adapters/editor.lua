local make_logged = require("application.helpers.make_logged")

local drag_offsets = {
	down = { visual = "'>+1", normal = ".+1", insert = ".+1" },
	up = { visual = "'<-2", normal = ".-2", insert = ".-2" },
}

---@type EditorAdapter
local M = {
	drag = function(opts)
		local offsets = drag_offsets[opts.direction]
		local mode = opts.mode

		if mode == "visual" then
			vim.cmd("normal! " .. vim.api.nvim_replace_termcodes("<Esc>", true, false, true))
			vim.cmd("'<,'>m " .. offsets.visual)
			vim.cmd("normal! gv=gv")
			return
		end

		if mode == "insert" then
			vim.cmd("normal! " .. vim.api.nvim_replace_termcodes("<Esc>", true, false, true))
			vim.cmd("m " .. offsets.insert)
			vim.cmd("normal! ==gi")
			return
		end

		vim.cmd("m " .. offsets.normal)
		vim.cmd("normal! ==")
	end,
	paragraph = function(direction)
		local commands = { next = "}", previous = "{" }
		vim.cmd("normal! " .. commands[direction])
	end,
	paste = function(position)
		local commands = { before = "P", after = "p" }
		vim.cmd("normal! " .. commands[position])
	end,
	delete_word = function()
		local keys = vim.api.nvim_replace_termcodes("<C-w>", true, false, true)
		vim.api.nvim_feedkeys(keys, "n", false)
	end,
	terminal_escape = function()
		local keys = vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true)
		vim.api.nvim_feedkeys(keys, "n", false)
	end,
	noop = function()
	end,
}

return make_logged("adapters/editor", M)
