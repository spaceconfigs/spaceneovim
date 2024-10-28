local ok, popup = pcall(require, "nui.popup")

if not ok then
  error("Failed to load plugin `MunifTanjim/nui.nvim`")
end

return {
  Popup = popup,
  event = require("nui.utils.autocmd").event,
}
