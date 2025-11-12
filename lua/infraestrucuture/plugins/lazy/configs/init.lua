return {
	{
		"tristone13th/lspmark.nvim",
		opts = {},
		dependencies = {
			{
				"nvim-telescope/telescope.nvim",
				dependencies = { "nvim-lua/plenary.nvim" },
			},
		},
	},
	{
		"natecraddock/workspaces.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		opts = {},
	},
	{
		"folke/lazydev.nvim",
		opts = {},
		ft = "lua",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		branch = "master",
		main = "nvim-treesitter.configs",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-context",
				opts = function()
					vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "none" })
					return {
						multiline_threshold = 1,
					}
				end,
			},
			{ "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
			"dlvandenberg/tree-sitter-angular",
		},
		opts = function()
			vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "none" })

			return {
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"markdown",
					"html",
					"markdown_inline",
				},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
				},
				additional_vim_regex_highlighting = false,
			}
		end,
	},
	{ "neovim/nvim-lspconfig" },
	{
		"folke/noice.nvim",
		event = "BufRead",
		opts = {
			routes = {
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "written",
					},
					opts = { skip = true },
				},
			},
			messages = {
				enabled = true,
			},
			views = {
				cmdline_popup = {
					border = {
						style = "single",
						padding = { 2, 2 },
					},
					filter_options = {},
					win_options = {
						winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
					},
				},
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	{
		"windwp/nvim-ts-autotag",
		opts = {},
		lazy = false,
	},

	-- {
	-- 	"pmizio/typescript-tools.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	-- 	ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	-- 	opts = {},
	-- },

	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"echasnovski/mini.nvim",
			"HakonHarnes/img-clip.nvim",
		},
		lazy = false,
		opts = {
			render_modes = true,
			anti_conceal = {
				disabled_modes = { "n" },
			},
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{
		"akinsho/bufferline.nvim",
		branch = "main",
		opts = {
			options = {
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		},
	},

	{
		"folke/snacks.nvim",
		lazy = false,
		priority = 1000,
		dependencies = {
			{ "folke/todo-comments.nvim" },
		},
		opts = {
			notifier = { enabled = true },
			quickfile = { enabled = true },
			terminal = { enabled = true },
			input = { enabled = true },
			bigfile = { enabled = true },
			scroll = { enabled = true },
			image = {
				enabled = true,
				doc = {
					inline = false,
				},
			},
			picker = {
				enabled = true,
				layout = "nitaicharan",
				layouts = {
					nitaicharan_lines = {
						layout = {
							box = "vertical",
							backdrop = false,
							row = -0.0000000000000000001,
							width = 0,
							height = 0.2,
							border = "none",
							title = " {title} {live} {flags}",
							title_pos = "left",
							{ win = "input", height = 1, border = "none" },
							{
								box = "horizontal",
								{ win = "list", border = "none" },
								{ win = "preview", title = "{preview}", width = 0.6, border = "none" },
							},
						},
					},
					nitaicharan = {
						layout = {
							box = "horizontal",
							backdrop = false,
							width = 0,
							height = 0,
							{
								box = "vertical",
								{
									win = "preview",
									height = 0.8,
									title_pos = "center",
								},
								{
									win = "input",
									height = 1,
									border = "none",
									title_pos = "center",
								},
								{ win = "list", title_pos = "center", border = "none" },
							},
						},
					},
				},
				sources = {
					explorer = {
						layout = {
							layout = {
								box = "vertical",
								backdrop = true,
								width = 0.8,
								height = 0.8,
								{ win = "list", border = "rounded" },
							},
						},
					},
				},
			},
			styles = {
				terminal = {
					position = "float",
					width = 0,
					height = 0,
				},
			},
		},
	},

	{ "hedyhli/outline.nvim", opts = {} },

	{
		"yetone/avante.nvim",
		-- lazy = false,
		version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
		opts = {
			provider = "claude",
			providers = {
				claude = {
					endpoint = "https://api.anthropic.com",
					model = "claude-sonnet-4-20250514",
					timeout = 30000, -- Timeout in milliseconds
					extra_request_body = {
						temperature = 0.75,
						max_tokens = 20480,
					},
				},
			},
		},
		build = "make", -- if you want to build from source then do make BUILD_FROM_SOURCE=true
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			"ibhagwan/fzf-lua", -- for file_selector provider fzf
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"MeanderingProgrammer/render-markdown.nvim",
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
		},
	},
	{
		"NickvanDyke/opencode.nvim",
		dependencies = {
			{ "folke/snacks.nvim", opts = { input = {}, picker = {} } },
		},
		config = function()
			vim.opt.autoread = true
		end,
	},
	{
		"coder/claudecode.nvim",
		dependencies = {
			"folke/snacks.nvim",
		},
		opts = {},
	},
	{
		"ravitemer/mcphub.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		build = "bundled_build.lua",
		opts = { use_bundled_binary = true },
	},
	{
		"numToStr/Comment.nvim",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
	},

	{
		"saghen/blink.cmp",
		version = "*",
		dependencies = {
			{ "saghen/blink.compat", opts = { enable_events = true } },
			"rafamadriz/friendly-snippets",
			"Kaiser-Yang/blink-cmp-avante",
			{
				"Exafunction/codeium.nvim",
				dependencies = {
					"nvim-lua/plenary.nvim",
				},
				opts = {},
			},
		},
		opts = {
			completion = {
				ghost_text = {
					enabled = true,
					show_with_menu = false,
				},
				menu = {
					auto_show = false,
				},
			},
			keymap = {
				["<CR>"] = nil,
				["<Right>"] = { "accept", "fallback" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "avante", "lsp", "path", "snippets", "buffer", "codeium" },
				providers = {
					avante = {
						module = "blink-cmp-avante",
						name = "Avante",
					},
					codeium = {
						name = "codeium",
						module = "blink.compat.source",
						score_offset = 3,
					},
				},
			},
			fuzzy = { implementation = "prefer_rust" },
			cmdline = {
				keymap = {
					["<up>"] = { "select_prev", "fallback" },
					["<down>"] = { "select_next", "fallback" },
					["<right>"] = { "accept", "fallback" },
					["<left>"] = { "fallback" },
					["<cr>"] = { "fallback" },
					["<esc>"] = {
						"hide",
						"cancel",
						function()
							if vim.fn.getcmdtype() ~= "" then
								vim.api.nvim_feedkeys(
									vim.api.nvim_replace_termcodes("<C-c>", true, true, true),
									"n",
									true
								)
								return
							end
						end,
					},
				},
				completion = {
					ghost_text = {
						enabled = true,
					},
					menu = {
						auto_show = false,
					},
				},
			},
		},
		opts_extend = { "sources.default" },
	},

	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod" },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } }, -- Optional
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
	},

	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
	},

	{ "mfussenegger/nvim-dap" },

	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },

	{ "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } },

	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-treesitter/nvim-treesitter",
		},
	},

	{
		"nvim-telescope/telescope-dap.nvim",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},

	{ "mfussenegger/nvim-lint" },

	{ "folke/trouble.nvim", opts = {} },

	-- {
	--   "maskudo/devdocs.nvim",
	--   dependencies = {
	--     "folke/snacks.nvim",
	--   },
	--   opts = {},
	-- },

	{
		"nitaicharan/devdocs.nvim",
		dependencies = {
			"folke/snacks.nvim",
		},
		opts = {},
	},

	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				["*"] = { "codespell" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				htmlangular = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				graphql = { "prettierd", "prettier", stop_after_first = true },
				lua = { "stylua" },
				python = { "isort", "black", stop_after_first = true },
				java = { "google-java-format" },
			},
		},
	},

	{ "lewis6991/hover.nvim" },

	{ "folke/flash.nvim", opts = {} },

	{ "smoka7/hop.nvim", opts = {} },

	{
		"folke/which-key.nvim",
		opts = {
			preset = "modern",
			-- delay = 500,
			win = {
				padding = { 3, 3 }, -- extra window padding [top/bottom, right/left]
				wo = {},
			},
			layout = {
				align = "center", -- align columns center
			},
		},
		dependencies = { "echasnovski/mini.nvim" },
	},

	{ "Tastyep/structlog.nvim" },

	{
		"nvim-orgmode/orgmode",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter" },
		},
		opts = {},
	},

	{
		"epwalsh/obsidian.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			ui = { enable = false },
			workspaces = {
				{
					name = "Personal",
					path = vim.fn.expand("~") .. "/Notes",
				},
			},
		},
	},

	{ "dhruvasagar/vim-table-mode" },

	{
		"epwalsh/pomo.nvim",
		version = "*",
		dependencies = {
			"rcarriga/nvim-notify",
		},
	},

	{
		"nvimtools/hydra.nvim",
		opts = {},
	},

	{
		"Shatur/neovim-session-manager",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {},
	},

	{ "nvim-lualine/lualine.nvim" },

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			persist_mode = false,
			direction = "float",
			float_opts = {
				border = "curved",
			},
		},
	},

	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-jest",
		},
	},

	{
		"zaldih/themery.nvim",
		dependencies = {
			{ "EdenEast/nightfox.nvim", lazy = false, priority = 1000 },
			-- { "folke/tokyonight.nvim" },
			-- { "iruzo/matrix-nvim" },
			-- { "catppuccin/nvim",                 name = "catppuccin" },
			-- { "scottmckendry/cyberdream.nvim" },
			-- { "Mofiqul/vscode.nvim" },
			-- { "Mofiqul/dracula.nvim" },
			-- { "nyoom-engineering/oxocarbon.nvim" },
			-- { "AlexvZyl/nordic.nvim" },
		},
	},

	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
			"ibhagwan/fzf-lua", -- optional
		},
	},

	{
		"pwntester/octo.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"folke/snacks.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
	},

	{ "lewis6991/gitsigns.nvim", opts = {} },

	{ "sindrets/winshift.nvim" },
	{ "declancm/maximize.nvim" },
	{ "stevearc/stickybuf.nvim", opts = {} },
	{ "pocco81/true-zen.nvim" },
	{ "folke/twilight.nvim" },
	{ "folke/zen-mode.nvim" },
	{ "tiagovla/scope.nvim", opts = {}, lazy = false },
	{ "HakonHarnes/img-clip.nvim", lazy = false },
	{ "norcalli/nvim-colorizer.lua", options = {}, lazy = false },
	{ "xiyaowong/transparent.nvim", options = {}, lazy = false },
	{
		"jinh0/eyeliner.nvim",
		lazy = false,
		opts = {
			highlight_on_key = true,
			dim = true,
		},
	},
	{
		"echasnovski/mini.nvim",
		lazy = false,
		init = function()
			require("mini.surround").setup({
				mappings = {
					add = "ys",
					delete = "ds",
					find = "sf",
					find_left = "sF",
					-- highlight = 'sh',
					replace = "cs",
					-- update_n_lines = 'sn',
					suffix_last = "l",
					suffix_next = "n",
				},
			})

			vim.api.nvim_set_keymap("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { noremap = true })
			vim.api.nvim_set_keymap("n", "yss", "ys_", { noremap = false })

			require("mini.pairs").setup()
			require("mini.ai").setup()
		end,
	},
	{
		"declancm/cinnamon.nvim",
		event = "BufRead",
		opts = {},
	},
	{
		"hedyhli/outline.nvim",
		event = "BufRead",
	},
	-- {
	-- 	"tris203/precognition.nvim",
	-- 	opts = {},
	-- 	event = "BufRead",
	-- },
	{
		"m4xshen/hardtime.nvim",
		event = "BufRead",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {
			disabled_keys = {
				["<Up>"] = { "" },
				["<Down>"] = { "" },
				["<Left>"] = { "" },
				["<Right>"] = { "" },
			},
		},
	},
	{
		"mistweaverco/kulala.nvim",
		opts = {
			global_keymaps = false,
		},
	},
	{
		"jellydn/hurl.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"MeanderingProgrammer/render-markdown.nvim",
		},
		ft = "hurl",
		opts = {},
	},
	{
		"mistricky/codesnap.nvim",
		build = "make",
		tag = "v1.6.3",
		opts = {
			mac_window_bar = false,
			title = "CodeSnap.nvim",
			bg_color = "#101010",
			has_breadcrumbs = true,
			has_line_number = true,
			show_workspace = true,
			bg_padding = 10,
			save_path = "~/",
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			vim.opt.termguicolors = true
			vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none", ctermbg = "none" })
			vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none", ctermbg = "none" })

			local function my_on_attach(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- default mappings
				-- api.config.mappings.default_on_attach(bufnr)

				-- vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
				-- vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
				-- vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
				-- vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
				-- vim.keymap.set("n", ".", api.node.run.cmd, opts("Run Command"))
				-- vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
				-- vim.keymap.set("n", "bd", api.marks.bulk.delete, opts("Delete Bookmarked"))
				-- vim.keymap.set("n", "bt", api.marks.bulk.trash, opts("Trash Bookmarked"))
				-- vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
				-- vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle Filter: No Buffer"))
				-- vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Filter: Git Clean"))
				-- vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
				-- vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
				-- vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
				-- vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
				-- vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
				-- vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
				-- vim.keymap.set("n", "F", api.live_filter.clear, opts("Live Filter: Clear"))
				-- vim.keymap.set("n", "f", api.live_filter.start, opts("Live Filter: Start"))
				-- vim.keymap.set("n", "L", api.node.open.toggle_group_empty, opts("Toggle Group Empty"))
				-- vim.keymap.set("n", "M", api.tree.toggle_no_bookmark_filter, opts("Toggle Filter: No Bookmark"))
				-- vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
				-- vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
				-- vim.keymap.set("n", "s", api.node.run.system, opts("Run System"))
				-- vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
				-- vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse All"))

				vim.keymap.set("n", "<A-j>", api.node.navigate.sibling.next, opts("Next Sibling"))
				vim.keymap.set("n", "<A-h>", api.node.navigate.sibling.prev, opts("Previous Sibling"))
				-- vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
				-- vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
				vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
				vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
				vim.keymap.set("n", "cf", api.fs.create, opts("Create File Or Directory"))
				vim.keymap.set("n", "cd", api.fs.create, opts("Create File Or Directory"))
				vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
				vim.keymap.set("n", "gr", api.tree.reload, opts("Refresh"))
				vim.keymap.set("n", "h", api.node.navigate.parent, opts("Parent Directory"))
				vim.keymap.set("n", "H", api.node.navigate.parent_close, opts("Close Directory"))
				vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
				vim.keymap.set("n", "m", api.fs.cut, opts("Cut"))
				vim.keymap.set("n", "ov", api.node.open.vertical, opts("Open: Vertical Split"))
				vim.keymap.set("n", "oh", api.node.open.horizontal, opts("Open: Horizontal Split"))
				vim.keymap.set("n", "oo", api.node.open.edit, opts("Open"))
				vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
				vim.keymap.set("n", "q", api.tree.close, opts("Close"))
				vim.keymap.set("n", "R", api.fs.rename, opts("Rename"))
				-- vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
				-- vim.keymap.set("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
				-- vim.keymap.set("n", "u", api.fs.rename_full, opts("Rename: Full Path"))
				vim.keymap.set("n", "th", api.tree.toggle_hidden_filter, opts("Toggle Filter: Dotfiles"))
				-- vim.keymap.set("n", "th", api.tree.toggle_custom_filter, opts("Toggle Filter: Hidden"))
				vim.keymap.set("n", "ti", api.tree.toggle_gitignore_filter, opts("Toggle Filter: Git Ignore"))
				vim.keymap.set("n", "ya", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
				vim.keymap.set("n", "yf", api.fs.copy.node, opts("Copy"))
				vim.keymap.set("n", "yn", api.fs.copy.filename, opts("Copy Name"))
				vim.keymap.set("n", "yb", api.fs.copy.basename, opts("Copy Basename"))
				vim.keymap.set("n", "yr", api.fs.copy.relative_path, opts("Copy Relative Path"))
			end

			local HEIGHT_RATIO = 0.8
			local WIDTH_RATIO = 0.5
			require("nvim-tree").setup({
				on_attach = my_on_attach,
				renderer = {
					root_folder_label = ":t",
				},
				update_focused_file = {
					enable = true,
				},
				respect_buf_cwd = true,
				root_dirs = { ".git", "package.json", "Makefile" },
				view = {
					centralize_selection = true,
					float = {
						enable = true,
						open_win_config = function()
							local screen_w = vim.opt.columns:get()
							local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
							local window_w = screen_w * WIDTH_RATIO
							local window_h = screen_h * HEIGHT_RATIO
							local window_w_int = math.floor(window_w)
							local window_h_int = math.floor(window_h)
							local center_x = (screen_w - window_w) / 2
							local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
							return {
								border = "rounded",
								relative = "editor",
								row = center_y,
								col = center_x,
								width = window_w_int,
								height = window_h_int,
							}
						end,
					},
					width = function()
						return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
					end,
				},
			})
		end,
	},
}
