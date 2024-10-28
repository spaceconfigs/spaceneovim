local ok, plugin = pcall(require, "harpoon")
if not ok then
	return vim.notify("Failed to load plugin `ThePrimeagen/harpoon`")
end

local result = {}
for key, value in pairs(plugin) do
	result[key] = value
end

result.mark = require("harpoon.mark")
result.ui = require("harpoon.ui")

return result
