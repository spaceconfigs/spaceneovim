local ok_cmp_nvim_lsp, blink_cmp = pcall(require, "blink.cmp")
local ok_mason, mason = pcall(require, "mason")
local ok_masonlspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
local snacks_ok, snacks = pcall(require, "snacks")

if not ok_mason then
  error("Failed to load plugin `williamboman/mason.nvim`")
  return
end

if not ok_masonlspconfig then
  error("Failed to load plugin `williamboman/mason-lspconfig.nvim`")
  return
end

if not ok_cmp_nvim_lsp then
  error("Failed to load plugin `Saghen/blink.cmp`")
  return
end

if not snacks_ok then
  error("Failed to load plugin `folke/snacks.nvim`")
end

return {
  mason_lspconfig = mason_lspconfig,
  blink_cmp = blink_cmp,
  snacks = snacks,
}
