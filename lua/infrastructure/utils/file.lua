local markers = { ".git", "package.json", "setup.py", "Makefile", "CMakeLists.txt" }

-- Anchor the project root on the given path (the current file) rather than on
-- the working directory, so the root is correct when nvim was started outside
-- the project. Returns nil when no marker is found.
local get_project_path = function(start)
	start = start or vim.loop.cwd()

	local marker = vim.fs.find(markers, { upward = true, stop = vim.loop.os_homedir(), path = start })[1]
	if not marker then
		return nil
	end

	return vim.fn.fnamemodify(marker, ":h")
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

		return get_project_path(vim.fn.expand("%:p:h")) or vim.loop.cwd()
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
				local project_path = get_project_path(vim.fn.fnamemodify(file_path, ":h"))
				local relative = project_path and vim.fs.relpath(project_path, file_path)

				-- Outside any project: an absolute path still locates the file,
				-- whereas a bare filename does not.
				return relative or file_path
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
