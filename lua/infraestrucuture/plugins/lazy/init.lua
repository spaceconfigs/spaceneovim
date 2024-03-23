local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--depth=1",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local ok, plugin = pcall(require, "lazy")
if not ok then
	return vim.notify("Failed to load package `folke/lazy.nvim`")
end

plugin.setup({
	defaults = {
		lazy = true,
	},
	spec = "infraestrucuture.plugins.lazy.configs",
})

return plugin
