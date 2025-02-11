local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.versior")
local gitsigns = plugin.gitsigns
local neogit = plugin.neogit
local snacks = plugin.snacks

M.blame_line = function()
  local message = {
    module = "adapters/versior",
    func = "blame_line",
  }
  logger_use_manage.debug(message)

  gitsigns.blame_line()
end

M.open = function()
  local message = {
    module = "adapters/versior",
    func = "open",
  }
  logger_use_manage.debug(message)

  neogit.open({ kind = 'auto' })
end

M.stage_files = function()
  local message = {
    module = "adapters/versior",
    func = "stage_files",
  }
  logger_use_manage.debug(message)

  gitsigns.stage_buffer()
end

M.unstage_files = function()
  local message = {
    module = "adapters/versior",
    func = "unstage_files",
  }
  logger_use_manage.debug(message)

  gitsigns.undo_stage_hunk()
end

M.browse = function()
  local message = {
    module = "adapters/versior",
    func = "browse",
  }
  logger_use_manage.debug(message)

  snacks.gitbrowse()
end

M.branchs = function()
  local message = {
    module = "adapters/versior",
    func = "branchs",
  }
  logger_use_manage.debug(message)

  snacks.picker.git_branches()
end

M.log = function()
  local message = {
    module = "adapters/versior",
    func = "log",
  }
  logger_use_manage.debug(message)

  snacks.picker.git_log()
end

return M
