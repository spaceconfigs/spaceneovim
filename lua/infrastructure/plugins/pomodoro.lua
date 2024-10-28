local ok_pomo, pomo = pcall(require, "pomo")
if not ok_pomo then
	error("Failed to load plugin `epwalsh/pomo.nvim`")
end

require("lualine").setup({
	sections = {
		lualine_x = {
			function()
				local timer = pomo.get_first_to_finish()
				if timer == nil then
					return ""
				end

				return "󰄉 " .. tostring(timer)
			end,
			"encoding",
			"fileformat",
			"filetype",
		},
	},
})

pomo.setup({
	sessions = {
		pomodoro = {
			{ name = "Work", duration = "25m" },
			{ name = "Short Break", duration = "5m" },
			{ name = "Work", duration = "25m" },
			{ name = "Short Break", duration = "5m" },
			{ name = "Work", duration = "25m" },
			{ name = "Long Break", duration = "15m" },
		},
	},
})

return {
	pomo = pomo,
}
