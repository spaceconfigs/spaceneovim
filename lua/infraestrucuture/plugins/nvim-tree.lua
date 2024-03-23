local ok, plugin = pcall(require, "nvim-tree")
if not ok then
	return vim.notify("Failed to load plugin `nvim-tree/nvim-tree.lua`")
end
local nvim_tree_api = require("nvim-tree.api")

local on_attach = function(bufnr)
	local function opts(desc)
		return {
			desc = "nvim-tree: " .. desc,
			buffer = bufnr,
			noremap = true,
			silent = true,
			nowait = true,
		}
	end

	vim.keymap.set("n", "d", nvim_tree_api.fs.remove, opts("Delete"))
	vim.keymap.set("n", "h", nvim_tree_api.node.navigate.parent, opts("Parent Directory"))
	vim.keymap.set("n", "H", nvim_tree_api.node.navigate.parent_close, opts("Close Directory"))
	vim.keymap.set("n", "R", nvim_tree_api.fs.rename, opts("Rename"))
	vim.keymap.set("n", "m", nvim_tree_api.marks.bulk.move, opts("Move Bookmarked"))
	vim.keymap.set("n", "p", nvim_tree_api.fs.paste, opts("Paste"))
	vim.keymap.set("n", "P", nvim_tree_api.node.open.preview, opts("Open Preview"))
	vim.keymap.set("n", "cf", nvim_tree_api.fs.create, opts("Create"))
	vim.keymap.set("n", "gr", nvim_tree_api.tree.reload, opts("Refresh"))
	vim.keymap.set("n", "oh", nvim_tree_api.node.open.horizontal, opts("Open: Horizontal Split"))
	vim.keymap.set("n", "ov", nvim_tree_api.node.open.vertical, opts("Open: Vertical Split"))
	vim.keymap.set("n", "ox", nvim_tree_api.node.run.system, opts("Run System"))
	vim.keymap.set("n", "yf", nvim_tree_api.fs.copy.node, opts("Copy"))
	vim.keymap.set("n", "ya", nvim_tree_api.fs.copy.absolute_path, opts("Copy Absolute Path"))
	vim.keymap.set("n", "yp", nvim_tree_api.fs.copy.filename, opts("Copy Name"))
	vim.keymap.set("n", "yr", nvim_tree_api.fs.copy.relative_path, opts("Copy Relative Path"))
	-- TODO: set 'oo' to tree and file on buffer
	-- TODO: set 'CR' to open tree branch
	vim.keymap.set("n", "oo", nvim_tree_api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "l", nvim_tree_api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "?", nvim_tree_api.tree.toggle_help, opts("Help"))
end

plugin.setup({
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	on_attach = on_attach,
	renderer = {
		highlight_git = true,
		root_folder_label = ":t",
		icons = {
			show = {
				git = false,
			},
		},
	},
	update_focused_file = {
		enable = true,
		update_root = true,
		debounce_delay = 15,
	},
	diagnostics = {
		enable = true,
		show_on_open_dirs = true,
	},
	git = {
		ignore = false,
		timeout = 200,
	},
	trash = {
		cmd = "trash",
	},
})

return require("nvim-tree.api").tree
