local make_logged = require("application.helpers.make_logged")
local chatbot_plugins = require("infrastructure.plugins.plugin_registry").chatbot()
local terminal = chatbot_plugins.claudecode.terminal
local mcphub_state = chatbot_plugins.mcphub_state

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
  send = function(text)
    if terminal.get_active_terminal_bufnr() then
      terminal.send_to_terminal(text, { submit = true })
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
  open_hub = function()
    if mcphub_state.ui_instance then
      mcphub_state.ui_instance:show()
    end
  end,
  scroll_to_bottom = function(buffer)
    local claude_bufnr = terminal.get_active_terminal_bufnr()
    if not claude_bufnr or buffer ~= claude_bufnr then
      return
    end

    local wins = vim.fn.win_findbuf(claude_bufnr)
    for _, win in ipairs(wins) do
      local line_count = vim.api.nvim_buf_line_count(claude_bufnr)
      vim.api.nvim_win_set_cursor(win, { line_count, 0 })
    end
  end,
}

return make_logged("adapters/chatbot", M)
