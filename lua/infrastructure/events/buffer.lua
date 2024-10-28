local M = {}

local hook = require("domain.contracts.hook_registry").buffer()

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

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = vim.api.nvim_create_augroup('BufferLintGroup', { clear = true }),
  callback = function()
    hook.onLint()
  end,
})

return M
