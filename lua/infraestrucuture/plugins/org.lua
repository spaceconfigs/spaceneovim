local neogit_ok, plugin = pcall(require, "orgmode")
if not neogit_ok then
	return vim.notify("Failed to load plugin `nvim-orgmode/orgmode`")
end

plugin.setup({
	org_agenda_files = "~/Notes/**/*",
	org_default_notes_file = "~/Notes/init.org",
  mappings = {
		disable_all = true,
	},
})

plugin.setup_ts_grammar()

return plugin
