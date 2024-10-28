local M = {}

local hook = require("domain.contracts.hook_registry").lifecycle()

vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('LivecycleGroup', { clear = true }),
  callback = function()
    hook.after_application_init()
  end,
})

return M
