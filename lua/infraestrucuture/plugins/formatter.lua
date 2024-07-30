local ok, conform = pcall(require, "conform")
if not ok then
	return vim.notify("Failed to load plugin `stevearc/conform.nvim`")
end

conform.setup({
	formatters_by_ft = {
		["*"] = { "codespell" },
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescriptreact = { "prettierd" },
		css = { "prettierd" },
		html = { "prettierd" },
		json = { "prettierd" },
		yaml = { "prettierd" },
		markdown = { "prettierd" },
		graphql = { "prettierd" },
		lua = { "stylua" },
		python = { "isort", "black", stop_after_first = true },
		java = { "google-java-format" },
	},
})

return conform
