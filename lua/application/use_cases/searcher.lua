local vim = vim
local M = {}

local logger_use_case = require("application.use_cases.logger")
local file_util = require("infraestrucuture.utils.file")

M.setup = function()
  return require("infraestrucuture.adapters.searcher")
end

M.oldfiles = function(opts)
  return function()
    local message = {
      module = "use_cases/file",
      func = "oldfiles",
      opts = opts,
    }
    logger_use_case.debug(message)
    local adapter = M.setup()

    opts = opts or {}
    opts.cwd_only = opts.cwd_only or false

    adapter.oldfiles(opts)
  end
end

M.search = function(opts)
  return function()
    local message = {
      module = "use_cases/searcher",
      func = "search",
      opts = opts,
    }
    logger_use_case.debug(message)
    local adapter = M.setup()
    local path = file_util.path()
    local location = opts.location or 'buffer'
    local in_live = opts.in_live or false

    if location == 'project' then
      path = file_util.pwd({ location = location })
    end

    adapter.search({
      location = location,
      path = path,
      in_live = in_live,
    })
  end
end

M.search_hover = function(location)
  return function()
    local message = {
      module = "use_cases/searcher",
      func = "search_hover",
      location = location,
    }
    logger_use_case.debug(message)
    local adapter = M.setup()
    location = location or 'buffer'

    local path = vim.api.nvim_buf_get_name(0)
    local text = vim.fn.expand("<cword>")

    if location == 'project' then
      path = file_util.pwd({ location = location })
    end

    adapter.search({
      location = location,
      path = path,
      text = text,
    })
  end
end

return M
