return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		-- or                              , branch = '0.1.x',
		dependencies = { "nvim-lua/plenary.nvim" },

		config = function()
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions") -- Adicione esta linha para importar as ações

			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<S-Down>"] = actions.preview_scrolling_down,
							["<S-Up>"] = actions.preview_scrolling_up,
						},
						n = {
							["<S-Down>"] = actions.preview_scrolling_down,
							["<S-Up>"] = actions.preview_scrolling_up,
						},
					},
				},
			})
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>fs", builtin.git_status, {})
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
		end,
	},
	{
		"junegunn/fzf.vim",
		dependencies = {
			{
				"junegunn/fzf",
				dir = "/opt/homebrew/Cellar/fzf/0.67.0",
				build = "./install --all",
			},
		},
		config = function()
			vim.keymap.set("n", "<leader>ag", ":Ag <CR>")
			vim.keymap.set("n", "<leader>rg", ":Rg <CR>")
		end,
	},

	{
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		cmd = "Spectre",
		keys = {
			{
				"<leader>sr",
				function()
					require("spectre").open()
				end,
				desc = "Search and replace (Spectre)",
			},
		},
		config = function()
			require("spectre").setup()
		end,
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		keys = {
			{
				"fs",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"ft",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"rf",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"ts",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"tf",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
}
