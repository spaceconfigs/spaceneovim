local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.searcher")
local fzf_opts = require("infraestrucuture.plugins.lazy.settings.fzf-lua")
local fzf = plugin.fzf

M.search = function(opts)
  local message = {
    module = "adapters/searcher",
    func   = "search",
    opts   = opts,
  }
  logger_use_manage.debug(message)

  if opts.in_live and opts.location == "project" then
    local temp = vim.deepcopy(fzf_opts.live_grep)
    return fzf.live_grep(temp)
  end

  if opts.location == "project" then
    return fzf.grep_project({ search = opts.text })
  end

  local temp = vim.deepcopy(fzf_opts.lgrep_curbuf)
  temp.search = opts.text
  return fzf.lgrep_curbuf(temp)
end

return M
