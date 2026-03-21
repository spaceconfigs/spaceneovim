local ok, plugin = pcall(require, "codesnap")
if not ok then
  error("Failed to load plugin `mistricky/codesnap.nvim/`")
end

return plugin
