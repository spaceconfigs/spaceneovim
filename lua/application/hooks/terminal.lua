local M = {}

local logger_use_case = require("application.use_cases.logger")

M.onOutput = function(args)
  local ok, terminal = pcall(require, "claudecode.terminal")
  if not ok then return end

  local claude_bufnr = terminal.get_active_terminal_bufnr()
  if not claude_bufnr or args.buf ~= claude_bufnr then return end

  local wins = vim.fn.win_findbuf(claude_bufnr)
  for _, win in ipairs(wins) do
    local line_count = vim.api.nvim_buf_line_count(claude_bufnr)
    vim.api.nvim_win_set_cursor(win, { line_count, 0 })
  end
end

M.onDestroy = function(args)
  local message = {
    module = "hooks/terminal",
    func = "onDestroy",
  }
  logger_use_case.debug(message)

  local status = vim.v.event.status
  if status == 0 or status == 130 then
    return vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(args.buf) then
        return
      end

      pcall(vim.api.nvim_buf_delete, args.buf, { force = true })
    end)
  end

  vim.notify(("Terminal exited with code %d"):format(status), vim.log.levels.WARN)
end

return M
