local make_logged = require("application.helpers.make_logged")
local terminal = require("infrastructure.plugins.registry").chatbot().claudecode.terminal

---@type ChatbotPort
local M = {
  toggle = function()
    local prev_win = vim.api.nvim_get_current_win()
    terminal.simple_toggle()
    vim.schedule(function()
      if vim.api.nvim_win_is_valid(prev_win) then
        vim.api.nvim_set_current_win(prev_win)
      end
    end)
  end,
  focus = function()
    vim.cmd("ClaudeCodeFocus")
  end,
  send = function(text, is_visual)
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
  end,
  add_buffer = function()
    vim.cmd("ClaudeCodeAdd %")
  end,
  add_file = function()
    vim.cmd("ClaudeCodeTreeAdd")
  end,
  add = function()
    vim.cmd("ClaudeCodeAdd")
  end,
  select_model = function()
    vim.cmd("ClaudeCodeSelectModel")
  end,
  diff_accept = function()
    vim.cmd("ClaudeCodeDiffAccept")
  end,
  diff_deny = function()
    vim.cmd("ClaudeCodeDiffDeny")
  end,
  status = function()
    vim.cmd("ClaudeCodeStatus")
  end,
  resume = function()
    vim.cmd("ClaudeCode --resume")
  end,
  continue = function()
    vim.cmd("ClaudeCode --continue")
  end,
}

return make_logged("adapters/chatbot", M)
