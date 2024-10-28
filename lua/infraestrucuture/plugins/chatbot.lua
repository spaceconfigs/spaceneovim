local ok_llm, llm = pcall(require, "llm")
local ok_gen, gen = pcall(require, "gen")
local ok_codegpt, codegpt = pcall(require, "codegpt")
local ok_plenary, plenary = pcall(require, "plenary")
local ok_ogpt, ogpt = pcall(require, "ogpt")
local ok_chatgpt, chatgpt = pcall(require, "chatgpt")
local ok_avante, avante = pcall(require, "avante")

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

if not ok_ogpt then
	return vim.notify("Failed to load plugin `huynle/ogpt.nvim`")
end

if not ok_chatgpt then
	return vim.notify("Failed to load plugin `jackMort/ChatGPT.nvim`")
end

if not ok_avante then
	return vim.notify("Failed to load plugin `yetone/avante.nvim`")
end

local openai_job = plenary.job:new({
	command = "pass",
	args = { "show", "openai.com/token" },
	on_exit = function(j)
		local result = table.concat(j:result(), "\n")
		vim.g["codegpt_openai_api_key"] = result
	end,
})
openai_job:start()

-- local claude_job = plenary.job:new({
-- 	command = "pass",
-- 	args = { "show", "anthropic.com/token" },
-- 	on_exit = function(j)
-- 		local result = table.concat(j:result(), "\n")
-- 		vim.g["ANTHROPIC_API_KEY"] = result
-- 	end,
-- })
-- claude_job:start()

gen.setup({
	model = "deepseek-coder",
	display_mode = "split",
})

-- chatgpt.setup({
-- 	api_key_cmd = "pass openai.com/token",
-- })

ogpt.setup()

llm.setup({
	backend = "ollama",
	model = "deepseek-coder",
	accept_keymap = "<C-j>",
	dismiss_keymap = "<C-g>",
	enable_suggestions_on_startup = false,
	lsp = {
		bin_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/mason/bin/llm-ls",
	},
	tokenizer = {
		repository = "bigcode/starcoder",
	},
})

avante.setup({
	provider = "claude",
})

return {
	avant = avante,
}
