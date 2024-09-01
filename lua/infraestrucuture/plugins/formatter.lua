local ok, conform = pcall(require, "conform")
if not ok then
	return vim.notify("Failed to load plugin `stevearc/conform.nvim`")
end

conform.setup({
	formatters_by_ft = {
		["*"] = { "codespell" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		graphql = { "prettier" },
		lua = { "stylua" },
		python = { "isort", "black", stop_after_first = true },
		java = { "google-java-format" },
	},
})

return conform
