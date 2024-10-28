local vim = vim
local M = {}

local make_logged = require("application.helpers.make_logged")
local logger_use_case = require("application.use_cases.logger")
local plugin = require("infrastructure.plugins.terminal")
local snacks = plugin.snacks

M.open = function(options)
  if options.type == "external" then
    local terminal_command = vim.fn.getenv("TERMINAL")
    terminal_command = terminal_command or ""

    if terminal_command == "" then
      logger_use_case.warn({
        module = "adapters/terminal",
        message = "TERMINAL environment variable not set",
      })
      return
    end

    return vim.fn.system(terminal_command)
  end

  snacks.terminal.toggle(nil, { interactive = true, auto_close = false, cwd = options.path })
end

M.close = function(options)
  if options.type == "external" then
    return
  end

  snacks.terminal.toggle(nil, { interactive = true, auto_close = false, cwd = options.path })
end

M.toggle = function(options)
  if vim.bo.buftype == "terminal" then
    local current_buf = vim.api.nvim_get_current_buf()
    for _, terminal in ipairs(snacks.terminal.list()) do
      if terminal.buf == current_buf then
        return terminal:hide()
      end
    end
  end

  return M.open(options)
end

return make_logged("adapters/terminal", M)
