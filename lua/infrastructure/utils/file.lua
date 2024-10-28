local get_project_path = function()
	local cwd = vim.loop.cwd()
	local path = vim.fs.find(
		{ ".git", "package.json", "setup.py", "Makefile", "CMakeLists.txt" },
		{ upward = true, stop = vim.loop.os_homedir(), path = cwd }
	)[1]

	return vim.fn.fnamemodify(path, ":h")
end

---@type FileUtilPort
local M = {
	project = function(location)
		location = location or "project"

		if location == "file" then
			local dir = vim.fn.expand("%:p:h")
			-- Special buffers (terminals, etc.) have no real file, so the expanded
			-- path is not a valid directory. Fall back to the working directory.
			if vim.fn.isdirectory(dir) == 1 then
				return dir
			end
			return vim.loop.cwd()
		end

		local cwd = vim.loop.cwd()
		local path = vim.fs.find(
			{ ".git", "package.json", "setup.py", "Makefile", "CMakeLists.txt" },
			{ upward = true, stop = vim.loop.os_homedir(), path = cwd }
		)[1]

		return vim.fn.fnamemodify(path, ":h")
	end,

	path = function()
		return vim.fn.expand("%:p")
	end,

	directory = function()
		return vim.fn.expand("%:p:h")
	end,

	get_path_from_file = function(location)
		location = location or "root"

		local mapper = {
			root = function()
				return vim.fn.expand("%:p")
			end,
			project = function()
				local file_path = vim.fn.expand("%:p")
				local project_path = get_project_path()
				local relative = vim.fs.relpath(project_path, file_path)

				return relative or vim.fn.fnamemodify(file_path, ":t")
			end,
			directory = function()
				local folder = vim.fn.expand("%:h:t")
				local filename = vim.fn.expand("%:t")
				return table.concat({ folder, filename }, "/")
			end,
			file = function()
				return vim.fn.expand("%:t")
			end,
		}

		return mapper[location]()
	end,
}

return M
