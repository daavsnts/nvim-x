return {
	{
		"olimorris/codecompanion.nvim",
		version = "17.33.0",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			adapters = {
				http = {
					copilot = function()
						return require("codecompanion.adapters").extend("copilot", {
							timeout = 10000,
						})
					end,
				},
				acp = {
					opencode = function()
						return require("codecompanion.adapters").extend("opencode", {
							commands = {
								default = {
									"opencode",
									"acp",
								},
							},
							schema = {
								model = {
									default = "gemini-3-pro-preview",
								},
							},
						})
					end,
				},
			},
			strategies = {
				chat = {
					adapter = "opencode",
				},
				inline = {
					adapter = "copilot",
					keymaps = {
						accept_change = {
							modes = { n = "ga" },
							description = "Accept the suggested change",
						},
						reject_change = {
							modes = { n = "gr" },
							description = "Reject the suggested change",
						},
					},
				},
				cmd = {
					adapter = "opencode",
				},
			},
			display = {
				chat = {
					window = {
						position = "right",
						width = 0.35,
					},
				},
			},
		},
		config = function(_, opts)
			require("codecompanion").setup(opts)
			vim.keymap.set(
				{ "n", "v" },
				"<leader>io",
				"<cmd>CodeCompanionChat<cr>",
				{ noremap = true, silent = true, desc = "Open CodeCompanion" }
			)

			vim.keymap.set(
				"n",
				"<leader>ii",
				"<cmd>CodeCompanion<cr>",
				{ noremap = true, silent = true, desc = "Open CodeCompanion Inline" }
			)

			vim.keymap.set(
				"v",
				"<leader>ii",
				":'<,'>CodeCompanion<cr>",
				{ noremap = true, silent = true, desc = "Open CodeCompanion Inline" }
			)

			--[[
			vim.keymap.set(
				"v",
				"<leader>ia",
				"<cmd>CodeCompanionChat Add<cr>",
				{ noremap = true, silent = true, desc = "CodeCompanion Add to Chat" }
			)
      ]]
			--

			vim.keymap.set(
				{ "n", "v" },
				"<leader>ia",
				"<cmd>CodeCompanionActions<cr>",
				{ noremap = true, silent = true, desc = "CodeCompanion Actions" }
			)
		end,
	},

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
		"zbirenbaum/copilot.lua",
		--dependencies = { "copilotlsp-nvim/copilot-lsp" },
		config = function()
			require("copilot").setup({
				suggestion = {
					auto_trigger = true,
					keymap = {
						accept = "<S-Tab>",
					},
				},
				filetypes = {
					sh = function()
						if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
							-- disable for .env files
							return false
						end
						return true
					end,
				},
			})
		end,
	},
}
