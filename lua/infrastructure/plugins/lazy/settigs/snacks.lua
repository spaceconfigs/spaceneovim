local pickers = {
  layout = {
    box = "vertical",
    backdrop = false,
    width = 0,
    height = 0.4,
    position = "bottom",
    border = "top",
    title = " {title} {live} {flags}",
    title_pos = "left",
    { win = "input", height = 1, border = "bottom" },
    {
      box = "horizontal",
      { win = "list",    border = "none" },
      { win = "preview", title = "{preview}", width = 0.6, border = "left" },
    },
  },
}
return { pickers = pickers }
