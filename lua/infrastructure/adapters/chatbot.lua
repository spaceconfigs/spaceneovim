local vim = vim
local M = {}

local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.chatbot")

M.toggle = function(opts)
  local mapper = {
    claudecode = "ClaudeCode",
  }

  vim.cmd(mapper[opts.provider])
end

M.session = function(opts)
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
  local mapper = {
    claudecode = "ClaudeCode",
  }

  vim.cmd(mapper[opts.provider])
end

M.zenmode = function(opts)
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
  local mapper = {
    claudecode = "ClaudeCodeSend",
  }

  vim.cmd(mapper[opts.provider])
end

M.add_file = function(opts)
  local mapper = {
    claudecode = "ClaudeCodeAdd",
  }

  vim.cmd(mapper[opts.provider])
end

M.select_model = function(opts)
  local mapper = {
    claudecode = "ClaudeCodeSelectModel",
  }

  vim.cmd(mapper[opts.provider])
end

M.accept_diff = function(opts)
  local mapper = {
    claudecode = "ClaudeCodeDiffAccept",
  }

  vim.cmd(mapper[opts.provider])
end

M.deny_diff = function(opts)
  local mapper = {
    claudecode = "ClaudeCodeDiffDeny",
  }

  vim.cmd(mapper[opts.provider])
end

return make_logged("adapters/chatbot", M)
