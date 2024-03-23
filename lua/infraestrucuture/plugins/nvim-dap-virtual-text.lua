local ok, plugin = pcall(require, "nvim-dap-virtual-text")
if not ok then
	return vim.notify("Failed to load plugin `theHamsta/nvim-dap-virtual-text`")
end

plugin.setup()
