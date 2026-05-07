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
					claude_code = function()
						return require("codecompanion.adapters").extend("claude_code", {
							env = {
								CLAUDE_CODE_OAUTH_TOKEN = "cmd: age -d -i ~/.ssh/id_ed25519_github_personal ~/.claude-o-auth-key.age",
							},
						})
					end,
					opencode = function()
						return require("codecompanion.adapters").extend("opencode", {
							commands = {
								default = {
									"opencode",
									"acp",
								},
							},
						})
					end,
				},
			},
			interactions = {
				chat = {
					adapter = { name = "opencode", model = "claude-haiku-4.5" },
					opts = {
						enabled = true,
					},
					callbacks = {
						["on_ready"] = {
							actions = {
								"interactions.background.builtin.chat_make_title",
							},
							-- Enable "on_ready" callback which contains the title generation action
							enabled = true,
						},
					},
				},
				inline = {
					adapter = { name = "opencode", model = "gpt-4.1" },
				},
				cmd = {
					adapter = { name = "copilot", model = "gpt-4.1" },
				},
				background = {
					adapter = {
						name = "copilot",
						model = "gpt-4.1",
					},
					chat = {
						opts = {
							enabled = true,
						},
					},
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
				filetypes = setmetatable({ text = false, csv = false }, {
					__index = function(_, _)
						local name = vim.fs.basename(vim.api.nvim_buf_get_name(0))
						if name:match("^%.env") then
							return false
						end
						return true
					end,
				}),
			})
		end,
	},

	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		config = true,
		keys = {
			{ "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
			{ "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
			{ "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
			{ "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
			{ "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
			{ "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
			{ "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
			{
				"<leader>cs",
				"<cmd>ClaudeCodeTreeAdd<cr>",
				desc = "Add file",
				ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
			},
			-- Diff management
			-- { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
			-- { "<leader>cr", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
		},
	},
}
