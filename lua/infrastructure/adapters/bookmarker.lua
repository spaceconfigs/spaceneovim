local make_logged = require("application.helpers.make_logged")
local bookmarker = require("infrastructure.plugins.plugin_registry").bookmarker()
local lspmark = bookmarker.lspmark

---@type BookmarkerPort
local M = {
  add = function()
    lspmark.toggle_bookmark()
    lspmark.save_bookmarks()
  end,
  remove = function()
    -- lspmark has no dedicated remove; toggling on a bookmarked line removes it.
    lspmark.toggle_bookmark()
    lspmark.save_bookmarks()
  end,
  list = function()
    lspmark.load_bookmarks()
    -- snacks.picker.marks({
    --   global = false
    -- })
  end,
}

return make_logged("adapters/bookmarker", M)
