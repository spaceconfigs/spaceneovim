local ok_dap, dap = pcall(require, "dap")
if not ok_dap then
	return vim.notify("Failed to load plugin `mfussenegger/nvim-dap`")
end

local widgets = require("dap.ui.widgets")
dap.ui = dap.ui or {}
dap.ui.widgets = widgets

local result = {}
for key, value in pairs(dap) do
	result[key] = value
end

result.utils = require("dap.utils")

local ok_nvim_dap_virtual_text, nvim_dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if not ok_nvim_dap_virtual_text then
	return vim.notify("Failed to load plugin `theHamsta/nvim-dap-virtual-text`")
end

nvim_dap_virtual_text.setup()

local ok_dapui, dapui = pcall(require, "dapui")
if not ok_dapui then
	return vim.notify("Failed to load pluing `rcarriga/nvim-dap-ui`")
end

return {
	dapui = dapui,
	dap = result,
}
