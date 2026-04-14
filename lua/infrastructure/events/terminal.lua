local M = {}

local hook = require("application.hooks.terminal")

local group = vim.api.nvim_create_augroup("TerminalGroup", { clear = true })

vim.api.nvim_create_autocmd("TermClose", {
  group = group,
  pattern = "*",
  callback = function(args)
    hook.onDestroy(args)
  end,
})

vim.api.nvim_create_autocmd({ "TermRequest", "TermResponse" }, {
  group = group,
  callback = function(args)
    hook.onOutput(args)
  end,
})

return M
