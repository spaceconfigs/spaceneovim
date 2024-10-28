local ok, lualine = pcall(require, "lualine")
if not ok then
	return vim.notify("Failed to load plugin `epwalsh/obsidian.nvim`")
end

local custom_theme = require("lualine.themes.auto")

custom_theme.normal.a = custom_theme.normal.a or {}
custom_theme.normal.b = custom_theme.normal.b or {}
custom_theme.normal.c = custom_theme.normal.c or {}
custom_theme.normal.x = custom_theme.normal.x or {}
custom_theme.normal.y = custom_theme.normal.y or {}
custom_theme.normal.z = custom_theme.normal.z or {}

custom_theme.insert.a = custom_theme.insert.a or {}
custom_theme.insert.b = custom_theme.insert.b or {}
custom_theme.insert.c = custom_theme.insert.c or {}
custom_theme.insert.x = custom_theme.insert.x or {}
custom_theme.insert.y = custom_theme.insert.y or {}
custom_theme.insert.z = custom_theme.insert.z or {}

custom_theme.visual.a = custom_theme.visual.a or {}
custom_theme.visual.b = custom_theme.visual.b or {}
custom_theme.visual.c = custom_theme.visual.c or {}
custom_theme.visual.x = custom_theme.visual.x or {}
custom_theme.visual.y = custom_theme.visual.y or {}
custom_theme.visual.z = custom_theme.visual.z or {}

custom_theme.command.a = custom_theme.command.a or {}
custom_theme.command.b = custom_theme.command.b or {}
custom_theme.command.c = custom_theme.command.c or {}
custom_theme.command.x = custom_theme.command.x or {}
custom_theme.command.y = custom_theme.command.y or {}
custom_theme.command.z = custom_theme.command.z or {}

custom_theme.normal.a.bg = nil
custom_theme.normal.a.fg = "#BFBFBF"
custom_theme.normal.b.bg = nil
custom_theme.normal.b.fg = "#BFBFBF"
custom_theme.normal.c.bg = nil
custom_theme.normal.c.fg = "#BFBFBF"
custom_theme.normal.x.bg = nil
custom_theme.normal.x.fg = "#BFBFBF"
custom_theme.normal.y.bg = nil
custom_theme.normal.y.fg = "#BFBFBF"
custom_theme.normal.z.bg = nil
custom_theme.normal.z.fg = "#BFBFBF"

custom_theme.insert.a.bg = nil
custom_theme.insert.a.fg = "#20A55C"
custom_theme.insert.b.bg = nil
custom_theme.insert.b.fg = "#BFBFBF"
custom_theme.insert.c.bg = nil
custom_theme.insert.c.fg = "#BFBFBF"
custom_theme.insert.x.bg = nil
custom_theme.insert.x.fg = "#BFBFBF"
custom_theme.insert.z.bg = nil
custom_theme.insert.z.fg = "#BFBFBF"
custom_theme.insert.y.bg = nil
custom_theme.insert.y.fg = "#BFBFBF"
custom_theme.insert.z.fg = nil
custom_theme.insert.z.fg = "#BFBFBF"

custom_theme.visual.a.bg = nil
custom_theme.visual.a.fg = "#bE95FF"
custom_theme.visual.b.bg = nil
custom_theme.visual.b.fg = "#BFBFBF"
custom_theme.visual.c.bg = nil
custom_theme.visual.c.fg = "#BFBFBF"
custom_theme.visual.x.bg = nil
custom_theme.visual.x.fg = "#BFBFBF"
custom_theme.visual.z.bg = nil
custom_theme.visual.z.fg = "#BFBFBF"
custom_theme.visual.y.bg = nil
custom_theme.visual.y.fg = "#BFBFBF"
custom_theme.visual.z.fg = nil
custom_theme.visual.z.fg = "#BFBFBF"
custom_theme.visual.a.bg = nil
custom_theme.visual.b.bg = nil

custom_theme.command.a.bg = nil
custom_theme.command.a.fg = "#08BDBA"
custom_theme.command.b.bg = nil
custom_theme.command.b.fg = "#BFBFBF"
custom_theme.command.c.bg = nil
custom_theme.command.c.fg = "#BFBFBF"
custom_theme.command.x.bg = nil
custom_theme.command.x.fg = "#BFBFBF"
custom_theme.command.z.bg = nil
custom_theme.command.z.fg = "#BFBFBF"
custom_theme.command.y.bg = nil
custom_theme.command.y.fg = "#BFBFBF"
custom_theme.command.z.fg = nil
custom_theme.command.z.fg = "#BFBFBF"
custom_theme.command.a.bg = nil
custom_theme.command.b.bg = nil

lualine.setup({
	options = {
		theme = custom_theme,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		globalstatus = true,
	},
	sections = {
		lualine_a = {},
		lualine_b = { "branch" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = {
			{
				function()
					return os.date("%H:%M")
				end,
				icon = "🕒",
			},
		},
	},
})

return lualine
