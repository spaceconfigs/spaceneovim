local ok, hover = pcall(require, "hover")
if not ok then
	error("Failed to load plugin `lewis6991/hover.nvim`")
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

local noice_ok, noice = pcall(require, "noice")
if not noice_ok then
	error("Failed to load plugin `folke/noice.nvim`")
end

return {
	hover = hover,
	noice = noice,
}
