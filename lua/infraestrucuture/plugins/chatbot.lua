local ok_gen, gen = pcall(require, "gen")
local ok_plenary, plenary = pcall(require, "plenary")
local ok_avante, avante = pcall(require, "avante")

if not ok_plenary then
	return vim.notify("Failed to load plugin `dpayne/CodeGPT.nvim`")
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

local claude_job = plenary.job:new({
	command = "pass",
	args = { "show", "anthropic.com/token" },
	on_exit = function(j)
		local result = table.concat(j:result(), "\n")
		vim.g["ANTHROPIC_API_KEY"] = result
	end,
})
claude_job:start()

vim.opt.laststatus = 3
avante.setup({
	provider = "claude",
})

return {
	avant = avante,
}
