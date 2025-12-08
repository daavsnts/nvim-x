return {
	{
		"zaldih/themery.nvim",
		lazy = false,
		config = function()
			require("themery").setup({
				globalAfter = [[ 
          vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
          vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
          vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
          vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })
          vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
          vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
          --vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
          vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
          vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
        ]],
				themes = {
					"gruvbox",
					"dracula",
					"cyberdream",
          "0x96f"
				},
				livePreview = true,
			})

			vim.keymap.set("n", "<leader>th", "<cmd>Themery<cr>", { desc = "Change theme" })
		end,
	},

	{
		"Mofiqul/dracula.nvim",
		config = function()
			require("dracula").setup({
				telescope = true,
				italic_comment = true,
			})
		end,
	},

	{
		"filipjanevski/0x96f.nvim",
		priority = 1000,
		config = function()
			require("0x96f").setup()
		end,
	},

	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		config = function()
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = false,
				bold = true,
				italic = {
					strings = false,
					emphasis = false,
					comments = false,
					operators = false,
					folds = false,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = true,
			})
		end,
	},

	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1000,
	},
}
