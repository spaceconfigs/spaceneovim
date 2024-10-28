local ok, cli = pcall(require, "sidekick.cli")

if not ok then
	error("Failed to load plugin `folke/sidekick.nvim`")
end

return {
	sidekick = cli,
}
