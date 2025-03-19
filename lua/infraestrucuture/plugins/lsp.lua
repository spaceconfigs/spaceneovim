local ok_cmp_nvim_lsp, blink_cmp = pcall(require, "blink.cmp")
local ok_lspconfig, lspconfig = pcall(require, "lspconfig")
local ok_mason, mason = pcall(require, "mason")
local ok_masonlspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
local ok_render_markdown, render_markdown = pcall(require, "render-markdown")

if not ok_mason then
  error("Failed to load plugin `williamboman/mason.nvim`")
  return
end

if not ok_masonlspconfig then
  error("Failed to load plugin `williamboman/mason-lspconfig.nvim`")
  return
end

if not ok_lspconfig then
  error("Failed to load plugin `neovim/nvim-lspconfig`")
  return
end

if not ok_cmp_nvim_lsp then
  error("Failed to load plugin `Saghen/blink.cmp`")
  return
end

if not ok_render_markdown then
  error("Failed to load plugin `MeanderingProgrammer/render-markdown.nvim`")
  return
end

-- vim.o.conceallevel = 2
-- vim.o.concealcursor = "i"

render_markdown.setup({
  win_options = {
    conceallevel = {
      -- Used when not being rendered, get user setting
      default = vim.api.nvim_get_option_value("conceallevel", {}),
      -- Used when being rendered, concealed text is completely hidden
      rendered = 3,
    },
    concealcursor = {
      -- Used when not being rendered, get user setting
      default = vim.api.nvim_get_option_value("concealcursor", {}),
      -- Used when being rendered, disable concealing text in all modes
      rendered = "",
    },
  },
})

mason.setup()

mason_lspconfig.setup({
  ensure_installed = {
    "lua_ls",
  },
  automatic_installation = true,
})

local snacks_ok, snacks = pcall(require, "snacks")
if not snacks_ok then
  error("Failed to load plugin `folke/snacks.nvim`")
end

return {
  mason_lspconfig = mason_lspconfig,
  lspconfig = lspconfig,
  blink_cmp = blink_cmp,
  snacks = snacks,
}
