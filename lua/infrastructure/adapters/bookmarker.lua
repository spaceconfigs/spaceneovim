local make_logged = require("application.helpers.make_logged")
local bookmarker = require("infrastructure.plugins.registry").bookmarker()
local telescope = bookmarker.telescope
local lspmark = bookmarker.lspmark

---@type BookmarkerPort
local M = {
  add = function()
    lspmark.toggle_bookmark()
    lspmark.save_bookmarks()
  end,
  remove = function()
    harpoon.mark.rm_file()
  end,
  remove_all = function()
    bookmarks.bookmark_clear_all()
  end,
  list = function()
    lspmark.load_bookmarks()
    -- snacks.picker.marks({
    --   global = false
    -- })
  end,
}

return make_logged("adapters/bookmarker", M)
