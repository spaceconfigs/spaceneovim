local M = {}

local hook = require("domain.contracts.hook_registry").debugger()

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("DebuggerGroup", { clear = true }),
  pattern = "DapStopped",
  callback = function()
    hook.on_debugger_activate()
  end,
})

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("DebuggerExitGroup", { clear = true }),
  pattern = { "DapTerminated", "DapExited" },
  callback = function()
    hook.on_debugger_deactivate()
  end,
})

return M
