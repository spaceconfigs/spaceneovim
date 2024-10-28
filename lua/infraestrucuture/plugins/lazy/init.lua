local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		-- "--depth=1",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local config = {
	spec = {
		{ import = "infraestrucuture.plugins.lazy.configs" },
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = true },
	defaults = {
		lazy = true,
	},
}

local ok, plugin = pcall(require, "lazy")
if not ok then
	return vim.notify("Failed to load package `folke/lazy.nvim`")
end

plugin.setup(config)

return plugin
