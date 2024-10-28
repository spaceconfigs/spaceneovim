local hop_ok, hop = pcall(require, "hop")
local flash_ok, flash = pcall(require, "flash")

if not hop_ok then
	error("Failed to load plugin `phaazon/hop.nvim`")
end

if not flash_ok then
	error("Failed to load plugin `folke/flash.nvim`")
end

return {
	hop = hop,
	flash = flash,
}
