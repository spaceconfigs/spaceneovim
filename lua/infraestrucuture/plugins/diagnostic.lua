local lint_ok, lint = pcall(require, "lint")
if not lint_ok then
  return vim.notify("Failed to load plugin `mfussenegger/nvim-lint`")
end

require("lint").linters_by_ft = {
  markdown = { "vale", "languagetool" },
  lua = { "luacheck" },
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
}

local trouble_ok, trouble = pcall(require, "trouble")
if not trouble_ok then
  return vim.notify("Failed to load plugin `folke/trouble.nvim`")
end

trouble.setup()

return {
  lint = lint,
  trouble = trouble
}
