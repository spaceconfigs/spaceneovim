local ok, hover = pcall(require, "hover")
if not ok then
	return vim.notify("Failed to load plugin `lewis6991/hover.nvim`")
end

hover.setup({
	init = function()
		require("hover.providers.lsp")
		require("hover.providers.gh")
		require("hover.providers.gh_user")
		require("hover.providers.jira")
		require("hover.providers.dap")
		require("hover.providers.fold_preview")
		-- require("hover.providers.diagnostic")
		require("hover.providers.man")
		require("hover.providers.dictionary")
	end,
})

return hover