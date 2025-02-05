local lspmark_ok = pcall(require, "lspmark")
if not lspmark_ok then
  return vim.notify("Failed to load plugin `tristone13th/lspmark.nvim`")
end
local lspmark = require('lspmark.bookmarks')

local ok_telescope = pcall(require, "telescope")
if not ok_telescope then
  return vim.notify("Failed to load plugin `nvim-telescope/telescope.nvim`")
end

local telescope = require("telescope").load_extension("lspmark")

vim.api.nvim_create_autocmd({ "DirChanged" }, {
  callback = function()
    lspmark.load_bookmarks()
  end,
  pattern = { "*" },
})

-- print(vim.inspect(lspmark))
return {
  telescope = telescope,
  lspmark = lspmark,
}
