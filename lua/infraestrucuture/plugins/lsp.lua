local ok_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local ok_lspconfig, lspconfig = pcall(require, "lspconfig")
local ok_null, null_ls = pcall(require, "null-ls")
local mason_ok, mason = pcall(require, "mason")
local ok_masonlspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")

if not mason_ok then
  vim.notify("Failed to load plugin `williamboman/mason.nvim`")
  return
end

if not ok_masonlspconfig then
  vim.notify("Failed to load plugin `williamboman/mason-lspconfig.nvim`")
  return
end

if not ok_null then
  vim.notify("Failed to load plugin `nvimtools/none-ls.nvim`")
  return
end

if not ok_lspconfig then
  vim.notify("Failed to load plugin `neovim/nvim-lspconfig`")
  return
end

if not ok_cmp_nvim_lsp then
  vim.notify("Failed to load plugin `hrsh7th/cmp-nvim-lsp`")
  return
end

mason.setup()

mason_lspconfig.setup({
  ensure_installed = {
    "lua_ls",
  },
  automatic_installation = true,
})

local sources = {
  null_ls.builtins.completion.spell,
  null_ls.builtins.code_actions.gitsigns,
  null_ls.builtins.formatting.codespell,
  null_ls.builtins.diagnostics.codespell,
  null_ls.builtins.diagnostics.write_good,
  null_ls.builtins.formatting.prettierd,
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.formatting.black
}

null_ls.setup({
  sources = sources,
  should_attach = function(bufnr)
    return not vim.api.nvim_buf_get_name(bufnr):match("NvimTree")
  end,
})

return {
  mason_lspconfig = mason_lspconfig,
  lspconfig = lspconfig,
  cmp_nvim_lsp = cmp_nvim_lsp,
}
