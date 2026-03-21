local lspmark_ok = pcall(require, "lspmark")
if not lspmark_ok then
  return vim.notify("Failed to load plugin `tristone13th/lspmark.nvim`")
end
local lspmark = require('lspmark.bookmarks')

local telescope = require("telescope").load_extension("lspmark")

vim.api.nvim_create_autocmd({ "DirChanged" }, {
  callback = function()
    lspmark.load_bookmarks()
  end,
  pattern = { "*" },
})

return {
  telescope = telescope,
  lspmark = lspmark,
}
