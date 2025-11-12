Snacks.keymap.del("n", "<leader><tab>l")
Snacks.keymap.del("n", "<leader><tab>o")
Snacks.keymap.del("n", "<leader><tab>f")
Snacks.keymap.del("n", "<leader><tab><tab>")
Snacks.keymap.del("n", "<leader><tab>]")
Snacks.keymap.del("n", "<leader><tab>d")
Snacks.keymap.del("n", "<leader><tab>[")

Snacks.keymap.del("n", "<leader>ft")

Snacks.keymap.set({ "n", "x" }, "<leader>ft", function()
  Snacks.explorer({ cwd = LazyVim.root() })
end, { desc = "Explorer Snacks (root dir)" })

Snacks.keymap.set({ "n", "x" }, "<leader>m==", function()
  LazyVim.format({ force = true })
end, { desc = "Format" })
Snacks.keymap.set({ "n", "x" }, "<leader>fs", ":write<cr>", { desc = "Save" })
Snacks.keymap.set({ "n", "x" }, "<leader><tab>", ":edit #<cr>", { desc = "Save" })
