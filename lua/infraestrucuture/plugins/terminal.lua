local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
  return vim.notify("Failed to load plugin `akinsho/toggleterm.nvim`")
end
toggleterm.setup()

local snacks_ok, snacks = pcall(require, "snacks")
if not snacks_ok then
  return vim.notify("Failed to load plugin `folke/snacks.nvim`")
end

return {
  toggleterm = toggleterm,
  snacks = snacks,
}
