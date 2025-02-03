local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.searcher")
local snacks = plugin.snacks

M.search = function(opts)
  local message = {
    module = "adapters/searcher",
    func   = "search",
    opts   = opts,
  }
  logger_use_manage.debug(message)

  if opts.location == "project" then
    return snacks.picker.grep({
      live = opts.text == nil,
      search = opts.text,
      layout = { preset = "ivy_split" }
    })
  end

  snacks.picker.grep({
    live = opts.text == nil,
    search = opts.text,
    buffers = { 0 },
    layout = { preset = "ivy_split" }
  })
end

return M
