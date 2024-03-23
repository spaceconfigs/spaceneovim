local ok, plugin = pcall(require, "dapui")
if not ok then
	return vim.notify("Failed to load pluing `rcarriga/nvim-dap-ui`")
end

return plugin
