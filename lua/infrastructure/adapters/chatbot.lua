local vim = vim
local M = {}

local logger_use_case = require("application.use_cases.logger")
local plugin = require("infrastructure.plugins.chatbot")

M.toggle = function(opts)
  local message = {
    module = "adapters/chatbot",
    func = "toggle",
    opts = opts,
  }
  logger_use_case.debug(message)

  vim.cmd("ClaudeCode")
end

M.session = function(opts)
  local message = {
    module = "adapters/chatbot",
    func = "session",
    opts = opts,
  }
  logger_use_case.debug(message)

  local mapper = {
    start = "ClaudeCodeStart",
    continue = "ClaudeCode --continue",
    resume = "ClaudeCode --resume",
    list = "ClaudeCode --resume",
    buffer = "ClaudeCodeFocus",
    toggle = "ClaudeCode",
    stop = "ClaudeCodeStop",
  }

  local action = mapper[opts.action]
  vim.cmd(action)
end

M.edit = function(opts)
  local message = {
    module = "adapters/chatbot",
    func = "edit",
    opts = opts,
  }
  logger_use_case.debug(message)

  vim.cmd("ClaudeCodeSend")
end

M.zenmode = function(opts)
  local message = {
    module = "adapters/chatbot",
    func = "zenmode",
    opts = opts,
  }
  logger_use_case.debug(message)
  local mapper = {
    toggle = "ClaudeCode",
    start = "ClaudeCode",
    continue = "ClaudeCodeContinue",
    resume = "ClaudeCodeResume",
  }

  local cmd = mapper[opts.action]
  vim.cmd(cmd)
end

M.send_prompt = function()
  local message = {
    module = "adapters/chatbot",
    func = "send_prompt",
  }
  logger_use_case.debug(message)

  vim.cmd("ClaudeCodeSend")
end

M.add_file = function()
  local message = {
    module = "adapters/chatbot",
    func = "add_file",
  }
  logger_use_case.debug(message)

  vim.cmd("ClaudeCodeAdd %")
end

M.select_model = function()
  local message = {
    module = "adapters/chatbot",
    func = "select_model",
  }
  logger_use_case.debug(message)

  vim.cmd("ClaudeCodeSelectModel")
end

M.accept_diff = function()
  local message = {
    module = "adapters/chatbot",
    func = "accept_diff",
  }
  logger_use_case.debug(message)

  vim.cmd("ClaudeCodeDiffAccept")
end

M.deny_diff = function()
  local message = {
    module = "adapters/chatbot",
    func = "deny_diff",
  }
  logger_use_case.debug(message)

  vim.cmd("ClaudeCodeDiffDeny")
end

return M
