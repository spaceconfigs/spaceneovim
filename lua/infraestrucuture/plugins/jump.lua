local hop_ok, hop = pcall(require, "hop")
local flash_ok, flash = pcall(require, "flash")

if not hop_ok then
	return vim.notify("Failed to load plugin `phaazon/hop.nvim`")
end
hop.setup()

if not flash_ok then
	return vim.notify("Failed to load plugin `folke/flash.nvim`")
end
flash.setup()

return {
	hop = hop,
	flash = flash,
}
