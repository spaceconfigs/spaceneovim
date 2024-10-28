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

  local mapper = {
    claudecode = "ClaudeCode",
  }

  vim.cmd(mapper[opts.provider])
end

M.session = function(opts)
  local message = {
    module = "adapters/chatbot",
    func = "session",
    opts = opts,
  }
  logger_use_case.debug(message)

  local mapper = {
    claudecode = {
      start = "ClaudeCode",
      continue = "ClaudeCode --continue",
      resume = "ClaudeCode --resume",
      list = "ClaudeCode --resume",
      buffer = "ClaudeCode",
      toggle = "ClaudeCode",
      stop = "ClaudeCode",
    },
  }

  local action = mapper[opts.provider][opts.action]
  vim.cmd(action)
end

M.edit = function(opts)
  local message = {
    module = "adapters/chatbot",
    func = "edit",
    opts = opts,
  }
  logger_use_case.debug(message)

  local mapper = {
    claudecode = "ClaudeCode",
  }

  vim.cmd(mapper[opts.provider])
end

M.zenmode = function(opts)
  local message = {
    module = "adapters/chatbot",
    func = "zenmode",
    opts = opts,
  }
  logger_use_case.debug(message)

  local mapper = {
    claudecode = {
      toggle = "ClaudeCode",
      start = "ClaudeCode",
      continue = "ClaudeCode --continue",
      resume = "ClaudeCode --resume",
    },
  }

  local cmd = mapper[opts.provider][opts.action]
  vim.cmd(cmd)
end

M.send_prompt = function(opts)
  local message = {
    module = "adapters/chatbot",
    func = "send_prompt",
    opts = opts,
  }
  logger_use_case.debug(message)

  local mapper = {
    claudecode = "ClaudeCodeSend",
  }

  vim.cmd(mapper[opts.provider])
end

M.add_file = function(opts)
  local message = {
    module = "adapters/chatbot",
    func = "add_file",
    opts = opts,
  }
  logger_use_case.debug(message)

  local mapper = {
    claudecode = "ClaudeCodeAdd",
  }

  vim.cmd(mapper[opts.provider])
end

M.select_model = function(opts)
  local message = {
    module = "adapters/chatbot",
    func = "select_model",
    opts = opts,
  }
  logger_use_case.debug(message)

  local mapper = {
    claudecode = "ClaudeCodeSelectModel",
  }

  vim.cmd(mapper[opts.provider])
end

M.accept_diff = function(opts)
  local message = {
    module = "adapters/chatbot",
    func = "accept_diff",
    opts = opts,
  }
  logger_use_case.debug(message)

  local mapper = {
    claudecode = "ClaudeCodeDiffAccept",
  }

  vim.cmd(mapper[opts.provider])
end

M.deny_diff = function(opts)
  local message = {
    module = "adapters/chatbot",
    func = "deny_diff",
    opts = opts,
  }
  logger_use_case.debug(message)

  local mapper = {
    claudecode = "ClaudeCodeDiffDeny",
  }

  vim.cmd(mapper[opts.provider])
end

return M
