local vim = vim

local ok, which_key = pcall(require, "which-key")
if not ok then
  error("Failed to load plugin `folke/which-key.nvim`")
end

return which_key
