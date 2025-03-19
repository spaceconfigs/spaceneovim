local lint_ok, lint = pcall(require, "lint")
if not lint_ok then
  error("Failed to load plugin `mfussenegger/nvim-lint`")
end

require("lint").linters_by_ft = {
  markdown = { "vale", "languagetool" },
  lua = { "luacheck" },
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
}

local trouble_ok, trouble = pcall(require, "trouble")
if not trouble_ok then
  error("Failed to load plugin `folke/trouble.nvim`")
end

trouble.setup()

local snacks_ok, snacks = pcall(require, "snacks")
if not snacks_ok then
  error("Failed to load plugin `folke/snacks.nvim`")
end


return {
  lint = lint,
  trouble = trouble,
  snacks = snacks,
}
