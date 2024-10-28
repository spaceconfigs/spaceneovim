local interface = require("domain.interfaces.mapper")

interface.setup = function(package, config)
	local lsp_usecase = config.lsp
	local packager_usecase = config.packager
	local tree_usecase = config.tree
	local terminal_usecase = config.terminal
	local commenter_usecase = config.commenter
	local versior_usecase = config.versior
	local projector_usecase = config.projector
end

return interface
