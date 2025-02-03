local snacks_ok, snacks = pcall(require, "snacks")
if not snacks_ok then
  return vim.notify("Failed to load plugin `folke/snacks.nvim`")
end

return {
  snacks = snacks,
}
