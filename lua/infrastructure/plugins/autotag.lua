local ok, autotag = pcall(require, "nvim-ts-autotag")
if not ok then
	error("Failed to load plugin `windwp/nvim-ts-autotag`")
end

autotag.setup({})

return {
	autotag = autotag,
	internal = require("nvim-ts-autotag.internal"),
}
