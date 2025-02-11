local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.file")
local snacks_opts = require("infraestrucuture.plugins.lazy.settigs.snacks")
local snacks = plugin.snacks

-- snacks.picker.smart({
--   multi = { "recent", "files" },
--   format = "file",     -- use `file` format for all sources
--   matcher = {
--     cwd_bonus = true,  -- boost cwd matches
--     frecency = true,   -- use frecency boosting
--     sort_empty = true, -- sort even when the filter is empty
--   },
--   transform = "unique_file",
--   layout = { preset = "nitaicharan" },
-- })

-- snacks.picker.files({
--   layout = { preset = "nitaicharan" },
-- })

M.oldfiles = function(opts)
  local message = {
    module = "adapters/file",
    func = "oldfiles",
    opts = opts,
  }
  logger_use_manage.debug(message)


  snacks.picker.recent({ layout = { preset = "nitaicharan" } })
end

M.list = function(opts)
  local message = {
    module = "adapters/file",
    func = "list",
    opts = opts,
  }
  logger_use_manage.debug(message)

  local cwd = opts and opts.path
  snacks.picker.smart({
    multi = { "files" },
    layout = { preset = "nitaicharan" },
    cwd = cwd,
  })
end

return M
