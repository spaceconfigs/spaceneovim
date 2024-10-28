local M = {}

local hook = require("application.hooks.debugger")

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("DebuggerGroup", { clear = true }),
  pattern = "DapStopped",
  callback = function()
    hook.onActivate()
  end,
})

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("DebuggerExitGroup", { clear = true }),
  pattern = { "DapTerminated", "DapExited" },
  callback = function()
    hook.onDeactivate()
  end,
})

return M
