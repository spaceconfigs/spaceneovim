local ok, twilight = pcall(require, "twilight")

if not ok then
	return vim.notify("Failed to load plugin `folke/twilight.nvim`")
end
twilight.setup()

local zen_mode_ok, zen_mode = pcall(require, "zen-mode")
if not zen_mode_ok then
	return vim.notify("Failed to load plugin `folke/zen-mode.nvim`")
end
zen_mode.setup({ plugins = { twilight = { enabled = false } } })

local true_zen_ok, true_zen = pcall(require, "true-zen")
if not true_zen_ok then
	return vim.notify("Failed to load plugin `pocco81/true-zen.nvim`")
end
true_zen.setup()

return {
	true_zen = true_zen,
	zen_mode = zen_mode,
	twilight = twilight,
}
