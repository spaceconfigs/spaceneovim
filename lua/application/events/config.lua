local group = vim.api.nvim_create_augroup("LifeciclyHooks", { clear = true })

-- Called once the host module's dependencies have been resolved
vim.api.nvim_create_autocmd("onModuleInit", {
	group = group,
	callback = function()
  end,
})
