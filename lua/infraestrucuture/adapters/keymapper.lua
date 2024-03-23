local vim = vim
local M = {}

local plugin = require("infraestrucuture.plugins.which-key")
local terminal_use_case = require("application.use_cases.terminal")
local commenter_use_case = require("application.use_cases.commenter")
local buffer_use_case = require("application.use_cases.buffer")
local lsp_use_case = require("application.use_cases.lsp")
-- plugin.register({
-- [";c"] = { name = "file", mode = "n" },
-- [";cf"] = { "<cmd>Telescope find_files<cr>", "Find File", mode = "n" },
-- [";cr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File", mode = "n" },
-- [";cn"] = { "<cmd>new<cr>", "New File", mode = "n" },
-- })

local normalOptions = {
	mode = "n",
	prefix = "<leader>",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
}

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		local keymapOptions = {
			buffer = ev.buf,
		}

		vim.keymap.set("n", "gD", lsp_use_case.go_declaration, keymapOptions)
		vim.keymap.set("n", "gd", lsp_use_case.go_definition, keymapOptions)
		vim.keymap.set("n", "K", lsp_use_case.show_documentation, keymapOptions)
		vim.keymap.set("n", "gi", lsp_use_case.go_implementation, keymapOptions)
		vim.keymap.set("n", "gr", lsp_use_case.show_references, keymapOptions)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("buffer_mappings_lspconfig", { clear = true }),
	pattern = { "dbui" },
	callback = function()
		local opts = { noremap = true, silent = true }

		vim.keymap.set("n", "q", "<Plug>(DBUI_Quit)", opts)
		vim.keymap.set("n", "h", "<Plug>(DBUI_GotoParentNode)", opts)
		vim.keymap.set("n", "<C-r>", "<Plug>(DBUI_Redraw)", opts)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("buffer_mappings_lspconfig", { clear = true }),
	pattern = {
		"help",
		"dap-float",
		"dbout",
	},
	callback = function()
		vim.opt_local.buflisted = false

		local opts = { buffer = true, noremap = true, silent = true }
		vim.keymap.set("n", "q", ":close<cr>", opts)
	end,
})

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "<esc>", "", opts)
keymap("x", "<esc>", "", opts)
keymap("v", "<esc>", "", opts)
keymap("c", "<esc>", "", opts)

keymap("i", "<c-c>", "", opts)
keymap("n", "<c-c>", "", opts)
keymap("x", "<c-c>", "", opts)
keymap("v", "<c-c>", "", opts)
keymap("c", "<c-c>", "", opts)

keymap("i", "<c-g>", "<esc>", opts)
keymap("n", "<c-g>", "<esc>", opts)
keymap("x", "<c-g>", "<esc>", opts)
keymap("v", "<c-g>", "<esc>", opts)
keymap("c", "<c-g>", "<esc>", opts)

keymap("n", "<c-h>", ":wincmd h<cr>", opts)
keymap("n", "<c-l>", ":wincmd l<cr>", opts)
keymap("n", "<c-j>", ":wincmd j<cr>", opts)
keymap("n", "<c-k>", ":wincmd k<cr>", opts)

keymap("n", "<c-up>", ":resize -2<cr>", opts)
keymap("n", "<c-down>", ":resize +2<cr>", opts)
keymap("n", "<c-left>", ":vertical resize -2<cr>", opts)
keymap("n", "<c-right>", ":vertical resize +2<cr>", opts)

keymap("n", "u", ":silent undo<cr>", opts)

keymap("c", "<C-j>", "<C-n>", opts)
keymap("c", "<C-k>", "<C-p>", opts)

local visualOptions = {
	[";"] = { commenter_use_case.toggle_current_line, "Comment toggle current line" },
	["<Tab>"] = { buffer_use_case.reopen, "Previous buffer" },
	["'"] = { terminal_use_case.toggle_buffer_dir, "Terminal" },
	mode = "v", -- VISUAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local visualMapping = {
	[";"] = { commenter_use_case.toggle_current_line_visual_mode, "Comment toggle linewise (visual)" },

	s = {
		name = "Search",
		-- s = { finder_use_case.grep_selected_text, "Search selected file" },
	},
	-- z = { "<cmd>TZNarrow<cr>", "Narrow" },
}
plugin.register(visualMapping, visualOptions)

local format_map = function(map)
	return {
		[map.key] = {
			map.method,
			map.description,
			buffer = map.buffer,
			silent = map.silent,
			noremap = map.noremap,
			nowait = map.nowait,
			mode = map.mode,
		},
	}
end

local format_group = function(map)
	return {
		[map.key] = {
			name = map.description,
			buffer = map.buffer,
			silent = map.silent,
			noremap = map.noremap,
			nowait = map.nowait,
			mode = map.mode,
		},
	}
end

M.regist = function(map)
	if map.method ~= nil then
		local result = format_map(map)
		return plugin.register(result)
	end

	local result = format_group(map)
	return plugin.register(result)
end

return M
