local jdtls_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/mason/packages/jdtls"
local workspace_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/jdtls-workspace"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name

local ok, jdtls = pcall(require, "jdtls")
if not ok then
	return
end
-- Failed to run config for nvim-jdtls
--     │...local/share/nvim/lazy/lazy.nvim/lua/lazy/core/loader.lua:373: attempt to call field 'setup' (a table value)
--      Projects/spaceconfig/spaceneovim/ftplugin/java.lua:6                                                      │
--     /usr/share/nvim/runtime/filetype.lua:36                                                                   │
--     /usr/share/nvim/runtime/filetype.lua:35

local extendedClientCapabilities = jdtls.extendedClientCapabilities

local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. jdtls_path .. "/lombok.jar",
		"-jar",
		vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		jdtls_path .. "/config_linux",
		"-data",
		workspace_dir,
	},

	root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

	settings = {
		java = {
			signatureHelp = { enabled = true },
			extendedClientCapabilities = extendedClientCapabilities,
			maven = {
				downloadSources = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			inlayHints = {
				parameterNames = {
					enabled = "all", -- literals, all, none
				},
			},
			format = {
				enabled = false,
			},
		},
	},

	init_options = {
		bundles = {},
	},
}
require("jdtls").start_or_attach(config)
