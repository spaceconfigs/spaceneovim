local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.searcher")
local snacks = plugin.snacks

-- snacks.picker.lines()
-- print(vim.inspect(snacks.picker))
-- snacks.picker.grep({
--   pattern = 'local'
-- })

M.search = function(opts)
  local message = {
    module = "adapters/searcher",
    func   = "search",
    opts   = opts,
  }
  logger_use_manage.debug(message)

  if opts.location == "project" then
    return snacks.picker.grep({
      layout = { preset = "nitaicharan" },
      live = opts.text == nil,
      search = opts.text,
    })
  end

  snacks.picker.lines({
    layout = { preset = "nitaicharan_lines" },
    pattern = opts.text,
  })
end

M.resume = function(opts)
  local message = {
    module = "adapters/searcher",
    func   = "resume",
    opts   = opts,
  }
  logger_use_manage.debug(message)

  snacks.picker.resume()
end
return M
