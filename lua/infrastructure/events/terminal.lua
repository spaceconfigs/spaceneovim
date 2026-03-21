vim.api.nvim_create_autocmd("TermClose", {
	pattern = "*",
	callback = function(args)
		local status = vim.v.event.status
		if status == 0 or status == 130 then
			return vim.schedule(function()
				if not vim.api.nvim_buf_is_valid(args.buf) then
					return
				end

				pcall(vim.api.nvim_buf_delete, args.buf, { force = true })
			end)
		end

		vim.notify(("Terminal exited with code %d"):format(status), vim.log.levels.WARN)
	end,
})
