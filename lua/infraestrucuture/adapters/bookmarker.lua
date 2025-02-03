local M = {}

local logger_use_manage = require("application.use_cases.logger")
local bookmarker = require("infraestrucuture.plugins.bookmarker")
local snacks = bookmarker.snacks

M.add = function()
  local message = {
    module = "adapters/add",
    func = "list",
  }
  logger_use_manage.debug(message)

  bookmarks.bookmark_toggle()
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

  snacks.picker.marks({ global = false, layout = { preset = "ivy_split" } })
end

return M
