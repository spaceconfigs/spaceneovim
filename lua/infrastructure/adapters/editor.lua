local make_logged = require("application.helpers.make_logged")

local drag_offsets = {
	down = { visual = "'>+1", normal = ".+1", insert = ".+1" },
	up = { visual = "'<-2", normal = ".-2", insert = ".-2" },
}

local filetype_rules = {
	markdown = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
	end,
}

---@type EditorPort
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
	setup_jumplist_motions = function()
		-- Count-prefixed j/k drop a jumplist mark first, so `5j` is undo-able with <C-o>.
		vim.keymap.set("n", "k", function()
			return (vim.v.count > 0 and "m'" .. vim.v.count or "") .. "k"
		end, { expr = true, silent = true })

		vim.keymap.set("n", "j", function()
			return (vim.v.count > 0 and "m'" .. vim.v.count or "") .. "j"
		end, { expr = true, silent = true })
	end,
	apply_rules = function(filetype)
		local rule = filetype_rules[filetype]
		if not rule then
			return
		end

		rule()
	end,
	current_path = function(buffer)
		return vim.api.nvim_buf_get_name(buffer or 0)
	end,
	cword = function()
		return vim.fn.expand("<cword>")
	end,
	visual_selection = function()
		local start_pos = vim.fn.getpos("'<")
		local end_pos = vim.fn.getpos("'>")
		local lines = vim.fn.getregion(start_pos, end_pos, { type = vim.fn.visualmode() })
		return table.concat(lines, "\n")
	end,
	current_mode = function()
		return vim.fn.mode()
	end,
	last_visual_mode = function()
		return vim.fn.visualmode()
	end,
	escape_visual = function()
		local key = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
		vim.api.nvim_feedkeys(key, "nx", false)
	end,
	prompt = function(label)
		return vim.fn.input(label)
	end,
	cwd = function()
		return vim.loop.cwd()
	end,
	toggle_option = function(name)
		if vim.opt[name]:get() then
			vim.opt[name] = false
			return
		end

		vim.opt[name] = true
	end,
}

return make_logged("adapters/editor", M)
