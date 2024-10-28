local M = {}

local hook = require("domain.contracts.hook_registry").terminal()

local group = vim.api.nvim_create_augroup("TerminalGroup", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
  group = group,
  pattern = "*",
  callback = function(args)
    hook.on_terminal_open(args)
  end,
})

vim.api.nvim_create_autocmd("TermClose", {
  group = group,
  pattern = "*",
  callback = function(args)
    hook.on_terminal_destroy({ buf = args.buf, status = vim.v.event.status })
  end,
})

vim.api.nvim_create_autocmd({ "TermRequest", "TermResponse" }, {
  group = group,
  callback = function(args)
    hook.on_terminal_output(args)
  end,
})

return M
