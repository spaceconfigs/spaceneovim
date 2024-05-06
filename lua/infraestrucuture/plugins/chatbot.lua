local ok_llm, llm = pcall(require, "llm")
local ok_gen, gen = pcall(require, "gen")
local ok_codegpt, codegpt = pcall(require, "codegpt")
local ok_plenary, plenary = pcall(require, "plenary")

if not ok_codegpt then
	return vim.notify("Failed to load plugin `dpayne/CodeGPT.nvim`")
end

if not ok_plenary then
	return vim.notify("Failed to load plugin `dpayne/CodeGPT.nvim`")
end

if not ok_llm then
	return vim.notify("Failed to load plugin `huggingface/llm.nvim`")
end

if not ok_gen then
	return vim.notify("Failed to load plugin `David-Kunz/gen.nvim`")
end

local job_codegpt = plenary.job:new({
	command = "pass",
	args = { "show", "openai.com/neovim" },
	on_exit = function(j)
		local result = table.concat(j:result(), "\n")
		vim.g["codegpt_openai_api_key"] = result
	end,
})
job_codegpt:start()

gen.setup({
	model = "deepseek-coder",
  display_mode = "split"
})

-- llm.setup({
-- 	backend = "ollama",
-- 	model = "codellama:7b",
-- 	accept_keymap = "<C-j>",
-- 	dismiss_keymap = "<C-g>",
-- 	enable_suggestions_on_startup = false,
-- 	lsp = {
-- 		bin_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/mason/bin/llm-ls",
-- 	},
-- 	tokenizer = {
-- 		repository = "bigcode/starcoder",
-- 	},
-- })
