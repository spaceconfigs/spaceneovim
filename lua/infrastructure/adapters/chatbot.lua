local M = {}

local make_logged = require("application.helpers.make_logged")
require("infrastructure.plugins.chatbot")

M.toggle = function()
  local terminal = require("claudecode.terminal")
  local prev_win = vim.api.nvim_get_current_win()
  terminal.simple_toggle()
  vim.schedule(function()
    if vim.api.nvim_win_is_valid(prev_win) then
      vim.api.nvim_set_current_win(prev_win)
    end
  end)
end

M.focus = function()
  vim.cmd("ClaudeCodeFocus")
end

M.send = function(text, is_visual)
  local terminal = require("claudecode.terminal")

  if is_visual then
    vim.cmd("'<,'>ClaudeCodeSend")
  end

  if terminal.get_active_terminal_bufnr() then
    local delay = is_visual and 500 or 0
    vim.defer_fn(function()
      terminal.send_to_terminal(text, { submit = true })
    end, delay)
    return
  end

  vim.cmd("ClaudeCode")
  vim.defer_fn(function()
    terminal.send_to_terminal(text, { submit = true })
  end, 500)
end

M.add_buffer = function()
  vim.cmd("ClaudeCodeAdd %")
end

M.add_file = function()
  vim.cmd("ClaudeCodeTreeAdd")
end

M.add = function()
  vim.cmd("ClaudeCodeAdd")
end

M.select_model = function()
  vim.cmd("ClaudeCodeSelectModel")
end

M.diff_accept = function()
  vim.cmd("ClaudeCodeDiffAccept")
end

M.diff_deny = function()
  vim.cmd("ClaudeCodeDiffDeny")
end

M.status = function()
  vim.cmd("ClaudeCodeStatus")
end

M.resume = function()
  vim.cmd("ClaudeCode --resume")
end

M.continue = function()
  vim.cmd("ClaudeCode --continue")
end

return make_logged("adapters/chatbot", M)
