local ok_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local ok_lspconfig, lspconfig = pcall(require, "lspconfig")
local ok_mason, mason = pcall(require, "mason")
local ok_masonlspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
local ok_render_markdown, render_markdown = pcall(require, "render-markdown")
local ok_telescope, telescope = pcall(require, "telescope")
local ok_fzf, fzf = pcall(require, "fzf-lua")

if not ok_mason then
  vim.notify("Failed to load plugin `williamboman/mason.nvim`")
  return
end

if not ok_masonlspconfig then
  vim.notify("Failed to load plugin `williamboman/mason-lspconfig.nvim`")
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

if not ok_render_markdown then
  vim.notify("Failed to load plugin `MeanderingProgrammer/render-markdown.nvim`")
  return
end

if not ok_telescope then
  return vim.notify("Failed to require package `telescope`")
end

local result = {}
for key, value in pairs(telescope) do
  result[key] = value
end
result.builtin = require("telescope.builtin")

if not ok_fzf then
  return vim.notify("Failed to require package `ibhagwan/fzf-lua`")
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

local fzf_opts = require("infraestrucuture.plugins.lazy.settings.fzf-lua")
fzf.setup(fzf_opts.horizontal)

return {
  mason_lspconfig = mason_lspconfig,
  lspconfig = lspconfig,
  cmp_nvim_lsp = cmp_nvim_lsp,
  telescope = result,
  fzf = fzf,
}
