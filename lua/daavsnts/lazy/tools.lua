return {
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		--build = "make install_jsregexp",

		dependencies = { "rafamadriz/friendly-snippets" },

		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			--[[local ls = require("luasnip")
      ls.filetype_extend("javascript", { "jsdoc" })

      --- TODO: What is expand?
      vim.keymap.set({"i"}, "<C-s>e", function() ls.expand() end, {silent = true})

      vim.keymap.set({"i", "s"}, "<C-s>;", function() ls.jump(1) end, {silent = true})
      vim.keymap.set({"i", "s"}, "<C-s>,", function() ls.jump(-1) end, {silent = true})

      vim.keymap.set({"i", "s"}, "<C-E>", function()
          if ls.choice_active() then
              ls.change_choice(1)
          end
      end, {silent = true})]]
			--
		end,
	},

	{
		"kylechui/nvim-surround",
		version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	{
		"axelvc/template-string.nvim",
		config = function()
			require("template-string").setup({
				filetypes = {
					"html",
					"typescript",
					"javascript",
					"typescriptreact",
					"javascriptreact",
					"vue",
					"svelte",
					"python",
					"cs",
				}, -- filetypes where the plugin is active
				jsx_brackets = true, -- must add brackets to JSX attributes
				remove_template_string = false, -- remove backticks when there are no template strings
				restore_quotes = {
					-- quotes used when "remove_template_string" option is enabled
					normal = [[']],
					jsx = [["]],
				},
			})
		end,
	},

	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = false,
					enable_rename = true,
					enable_close_on_slash = false,
				},
			})
		end,
	},

	{
		"chrisgrieser/nvim-spider",
		config = function()
			vim.keymap.set({ "n", "o", "x" }, "<A-Right>", "<cmd>lua require('spider').motion('w')<CR>")
			vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>")
			vim.keymap.set({ "n", "o", "x" }, "<A-Left>", "<cmd>lua require('spider').motion('b')<CR>")
		end,
	},

	{
		"bennypowers/template-literal-comments.nvim",
		opts = true,
		ft = {
			"javascript",
			"typescript",
		},
	},

	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},

	--[[
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = true })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
  ]]
	--

	{
		"echasnovski/mini.diff",
		config = function()
			local diff = require("mini.diff")
			diff.setup({
				-- Disabled by default
				source = diff.gen_source.none(),
			})
		end,
	},

	{
		"HakonHarnes/img-clip.nvim",
		opts = {
			filetypes = {
				codecompanion = {
					prompt_for_file_name = false,
					template = "[Image]($FILE_PATH)",
					use_absolute_path = true,
				},
			},
			keys = {
				{ "<leader>pi", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
			},
		},
	},

	{
		"MeanderingProgrammer/render-markdown.nvim", -- Make Markdown buffers look beautiful
		ft = { "markdown", "codecompanion" },
		opts = {
			render_modes = true, -- Render in ALL modes
			sign = {
				enabled = false, -- Turn off in the status column
			},
			latex = { enabled = false },
			overrides = {
				filetype = {
					codecompanion = {
						html = {
							tag = {
								buf = { icon = " ", highlight = "CodeCompanionChatIcon" },
								file = { icon = " ", highlight = "CodeCompanionChatIcon" },
								group = { icon = " ", highlight = "CodeCompanionChatIcon" },
								help = { icon = "󰘥 ", highlight = "CodeCompanionChatIcon" },
								image = { icon = " ", highlight = "CodeCompanionChatIcon" },
								symbols = { icon = " ", highlight = "CodeCompanionChatIcon" },
								tool = { icon = "󰯠 ", highlight = "CodeCompanionChatIcon" },
								url = { icon = "󰌹 ", highlight = "CodeCompanionChatIcon" },
							},
						},
					},
				},
			},
		},
	},

	{
		"kndndrj/nvim-dbee",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		build = function()
			require("dbee").install()
		end,
		config = function()
			require("dbee").setup()
			vim.keymap.set("n", "<leader>db", "<cmd>Dbee<cr>", { desc = "Database Explorer" })
		end,
	},

	{
		"mistweaverco/kulala.nvim",
		keys = {
			{ "<leader>kr", desc = "Send request" },
			{ "<leader>ka", desc = "Send all requests" },
			{ "<leader>kb", desc = "Open scratchpad" },
		},
		ft = { "http", "rest" },
		opts = {
			global_keymaps = true,
			global_keymaps_prefix = "<leader>k",
			kulala_keymaps_prefix = "",
		},
	},

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
      vim.keymap.set("n", "<leader>mp", "<Plug>MarkdownPreview", { silent = true, noremap = false })
      vim.keymap.set("n", "<leader>ms", "<Plug>MarkdownPreviewStop", { silent = true, noremap = false })
		end,
		ft = { "markdown" },
	},
}
