local ok, plugin = pcall(require, "nvim-devdocs")
if not ok then
  error("Failed to load plugin `nitaicharan/nvim-devdoc`")
end

return plugin
