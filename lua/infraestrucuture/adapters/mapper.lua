local interface = require("domain.interfaces.mapper")

interface.setup = function(package, config)
	local finder_use_case = config.finder
	local lsp_use_case = config.lsp
	local packager_use_case = config.packager
	local tree_use_case = config.tree
	local terminal_use_case = config.terminal
	local commenter_use_case = config.commenter
	local versior_use_case = config.versior
	local projector_use_case = config.projector
end

return interface
