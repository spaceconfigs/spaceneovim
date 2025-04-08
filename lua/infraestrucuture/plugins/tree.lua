local snacks_ok, snacks = pcall(require, "snacks")
if not snacks_ok then
  error("Failed to load plugin `folke/snacks.nvim`")
end

vim.api.nvim_set_hl(0, "SnacksPicker", { bg = "NONE" })

return {
  snacks = snacks,
}
