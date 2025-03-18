local vim = vim

local ok, which_key = pcall(require, "which-key")
if not ok then
  return vim.notify("Failed to load plugin `folke/which-key.nvim`")
end

return which_key
