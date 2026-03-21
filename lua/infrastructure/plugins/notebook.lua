local ok_jupytext, jupytext = pcall(require, "jupytext")
if not ok_jupytext then
	error("Failed to load plugin `goerz/jupytext.nvim`")
end

return {}
