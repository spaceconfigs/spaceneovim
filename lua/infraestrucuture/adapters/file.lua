local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.file")
local fzf = plugin.fzf

local fzf_opts = {
  winopts = {
    border = 'rounded',
    preview = {
      layout = 'vertical',
      vertical = 'up:60%',
    },
  },
}


M.oldfiles = function(opts)
  local message = {
    module = "adapters/file",
    func = "oldfiles",
    opts = opts,
  }
  logger_use_manage.debug(message)


  fzf.oldfiles(fzf_opts)
  -- plugin.telescope.builtin.oldfiles({ show_line = false, cwd_only = opts.cwd_only })
end

M.list = function(opts)
  local message = {
    module = "adapters/file",
    func = "list",
    opts = opts,
  }
  logger_use_manage.debug(message)

  local cwd = opts and opts.path
  local temp_opts = vim.deepcopy(fzf_opts)
  temp_opts.cwd = cwd

  fzf.files(temp_opts)
end

return M
