local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
  return vim.notify("Failed to load plugin `akinsho/toggleterm.nvim`")
end
toggleterm.setup()

return {
  toggleterm = toggleterm
}
