local M = {}

local logger_use_manage = require("application.use_cases.logger")
local bookmarker = require("infrastructure.plugins.bookmarker")
local telescope = bookmarker.telescope
local lspmark = bookmarker.lspmark

M.add = function()
  local message = {
    module = "adapters/add",
    func = "list",
  }
  logger_use_manage.debug(message)

  lspmark.toggle_bookmark()
  lspmark.save_bookmarks()
end

M.remove = function()
  local message = {
    module = "adapters/remove",
    func = "list",
  }
  logger_use_manage.debug(message)

  harpoon.mark.rm_file()
end

M.remove_all = function()
  local message = {
    module = "adapters/remove_all",
    func = "list",
  }
  logger_use_manage.debug(message)

  bookmarks.bookmark_clear_all()
end

M.list = function()
  local message = {
    module = "adapters/list",
    func = "list",
  }
  logger_use_manage.debug(message)

  lspmark.load_bookmarks()
  -- snacks.picker.marks({
  --   global = false
  -- })
end

return M
