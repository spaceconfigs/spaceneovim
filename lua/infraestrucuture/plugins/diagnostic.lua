local ok, lint = pcall(require, "lint")
if not ok then
	return vim.notify("Failed to load plugin `mfussenegger/nvim-lint`")
end

require("lint").linters_by_ft = {
	markdown = { "vale", "languagetool" },
	lua = { "luacheck" },
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
}

return lint
