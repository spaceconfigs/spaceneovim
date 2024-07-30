local ok, plugin = pcall(require, "dap")
if not ok then
	return vim.notify("Failed to load plugin `mfussenegger/nvim-dap`")

end
local widgets = require("dap.ui.widgets")
plugin.ui = plugin.ui or {}
plugin.ui.widgets = widgets

local result = {}
for key, value in pairs(plugin) do
	result[key] = value
end

result.utils = require("dap.utils")

return result
