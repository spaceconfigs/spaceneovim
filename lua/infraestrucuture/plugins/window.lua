local winshift_ok, winshift = pcall(require, "winshift")
if not winshift_ok then
	return vim.notify("Failed to load plugin `sindrets/winshift.nvim`")
end
winshift.setup()

local maximize_ok, maximize = pcall(require, "maximize")
if not maximize_ok then
	return vim.notify("Failed to load plugin `declancm/maximize.nvim`")
end

maximize.setup()

local stickybuf_ok, stickybuf = pcall(require, "stickybuf")
if not stickybuf_ok then
	return vim.notify("Failed to load plugin `stevearc/stickybuf.nvim`")
end
stickybuf.setup()

local zen_mode_ok, zen_mode = pcall(require, "zen-mode")
if not zen_mode_ok then
	return vim.notify("Failed to load plugin `folke/zen-mode.nvim`")
end
zen_mode.setup()

return {
	zen_mode = zen_mode,
	maximize = maximize,
}
