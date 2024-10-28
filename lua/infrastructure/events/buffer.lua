local M = {}

local hook = require("application.hooks.buffer")

vim.api.nvim_create_autocmd('BufRead', {
  group = vim.api.nvim_create_augroup('BufferGroup', { clear = true }),
  callback = function()
    hook.onInit()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('BufferInitGroup', { clear = true }),
  callback = function(args)
    hook.onBufferInit(args.match)
  end,
})

return M
