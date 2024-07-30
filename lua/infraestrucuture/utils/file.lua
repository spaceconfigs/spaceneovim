local M = {}

M.pwd = function(opts)
	opts = opts or {}
	opts.location = opts.location or "project"

	if opts.location == "file" then
		return vim.fn.expand("%:p:h")
	end

	local cwd = vim.loop.cwd()
	local path = vim.fs.find(
		{ ".git", "package.json", "setup.py", "Makefile", "CMakeLists.txt" },
		{ upward = true, stop = vim.loop.os_homedir(), path = cwd }
	)[1]

	return vim.fn.fnamemodify(path, ":h")
end

M.path = function()
	return vim.fn.expand("%:p")
end

return M
