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
									-- default = "claude-sonnet-4.5",
									-- default = "gemini-3-pro",
									default = "claude-opus-4.5",
                  -- default = "gemini-3-flash"
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
		"zbirenbaum/copilot.lua",
		-- dependencies = { "copilotlsp-nvim/copilot-lsp" },
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					auto_trigger = true,
					keymap = {
						accept = "<S-Tab>",
					},
				},
				nes = {
					enabled = false,
					auto_trigger = false,
					keymap = {
						--accept = "<S-Tab>",
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
