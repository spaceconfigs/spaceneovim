local M = {}

local hook = require("application.hooks.lifecycle")

vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('LivecycleGroup', { clear = true }),
  callback = function()
    hook.onModuleInit()
  end,
})

return M
