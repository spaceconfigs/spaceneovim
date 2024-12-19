local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.searcher")
local fzf = plugin.fzf

local fzf_grep_live_opts = {
  prompt = '> ',
  winopts = {
    preview = {
      layout = 'vertical',
      vertical = 'up:60%',
    },
  },
}

M.search = function(opts)
  local message = {
    module = "adapters/searcher",
    func   = "search",
    opts   = opts,
  }
  logger_use_manage.debug(message)

  local temp_opts = vim.deepcopy(fzf_grep_live_opts)
  temp_opts.search = opts.text

  if opts.in_live and opts.location == "project" then
    fzf.live_grep(fzf_grep_live_opts)
  end

  if opts.location == "project" then
    return fzf.grep_project(temp_opts)
  end

  return fzf.grep_curbuf(temp_opts)
end

return M
