return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")

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

			-- vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
			-- vim.keymap.set("n", "<leader>ag", builtin.live_grep, { desc = "Live Grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
			vim.keymap.set("n", "<leader>fs", builtin.git_status, { desc = "Git Status" })
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find keymaps" })
		end,
	},

	{
		"danielfalk/smart-open.nvim",
		branch = "0.2.x",
		config = function()
			require("telescope").load_extension("smart_open")

      vim.keymap.set("n", "<leader>ff", ":Telescope smart_open<CR>", { desc = "Smart Open" })
		end,
		dependencies = {
			"kkharji/sqlite.lua",
			-- Only required if using match_algorithm fzf
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			-- Optional.  If installed, native fzy will be used when match_algorithm is fzy
			{ "nvim-telescope/telescope-fzy-native.nvim" },
		},
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
			vim.keymap.set("n", "<leader>ag", ":Ag <CR>", { desc = "Ag Search", silent = true })
			vim.keymap.set("n", "<leader>rg", ":Rg <CR>", { desc = "Rg Search", silent = true })
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
