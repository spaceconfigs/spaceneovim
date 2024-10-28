local vim = vim

local make_logged = require("application.helpers.make_logged")
local logger_usecase = require("application.usecases.logger")
local plugin = require("infrastructure.plugins.plugin_registry").terminal()
local snacks = plugin.snacks

---@type TerminalPort
local M
M = {
  open = function(options)
    if options.type == "external" then
      local terminal_command = vim.fn.getenv("TERMINAL")
      terminal_command = terminal_command or ""

      if terminal_command == "" then
        logger_usecase.warn({
          module = "adapters/terminal",
          message = "TERMINAL environment variable not set",
        })
        return
      end

      return vim.fn.system(terminal_command)
    end

    snacks.terminal.toggle(nil, { interactive = true, auto_close = false, cwd = options.path })
  end,

  close = function(options)
    if options.type == "external" then
      return
    end

    snacks.terminal.toggle(nil, { interactive = true, auto_close = false, cwd = options.path })
  end,

  toggle = function(options)
    if vim.bo.buftype == "terminal" then
      local current_buf = vim.api.nvim_get_current_buf()
      for _, terminal in ipairs(snacks.terminal.list()) do
        if terminal.buf == current_buf then
          return terminal:hide()
        end
      end
    end

    return M.open(options)
  end,
  close_buffer = function(buffer)
    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(buffer) then
        return
      end

      pcall(vim.api.nvim_buf_delete, buffer, { force = true })
    end)
  end,
}

return make_logged("adapters/terminal", M)
