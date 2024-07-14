local M = {}

local hook = require("application.hooks.buffer")

vim.api.nvim_create_autocmd('BufRead', {
  group = vim.api.nvim_create_augroup('BufferGroup', { clear = true }),
  callback = function()
    hook.onInit()
  end,
})

return M
