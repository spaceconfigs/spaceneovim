local vim = vim

vim.opt.background = "dark"
vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.fileencoding = "utf-8"
vim.o.encoding = "utf-8"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.mouse = "a"
vim.opt.pumheight = 10
vim.opt.showmode = false
vim.opt.showtabline = 0
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.timeout = true
vim.opt.updatetime = 1000
vim.opt.timeoutlen = 250
vim.opt.ttimeoutlen = 10
vim.opt.undofile = true
vim.opt.updatetime = 100
vim.opt.writebackup = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.cursorline = false
vim.opt.number = true
vim.opt.laststatus = 3
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.relativenumber = true
vim.opt.numberwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.sidescrolloff = 8
vim.opt.guifont = "monospace:h17"
vim.opt.title = true
vim.opt.fillchars = vim.opt.fillchars + "eob: "
vim.opt.cmdheight = 0

vim.lsp.set_log_level("off")
vim.o.showtabline = 1
vim.o.laststatus = 0

vim.g.mapleader = "<space>"
vim.g.maplocalleader = "<space>"
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.fillchars:append({
	stl = " ",
})

vim.opt.shortmess:append("c")

local options = {
	completeopt = { "menuone", "noselect" },
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])

vim.filetype.add({
	extension = {
		conf = "dosini",
	},
})
