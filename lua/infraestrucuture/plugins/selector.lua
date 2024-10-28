local ok, plugin = pcall(require, "multicursors")
if not ok then
  return vim.notify("Failed to load plugin `nvim-tree/nvim-tree.lua`")
end

vim.g.VM_default_mappings = 0
vim.g.VM_mouse_mappings = 0
vim.g.VM_maps = {}

return plugin
