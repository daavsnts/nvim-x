return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			image = { enabled = true },
		},
	},

	--[[
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		-- Optional dependencies
		-- dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,

		config = function()
			local oil = require("oil")

			oil.setup({
				use_default_keymaps = true,
				watch_for_changes = true,
				view_options = {
					show_hidden = false,
					is_hidden_file = function(name, bufnr)
						return vim.startswith(name, ".")
					end,
					is_always_hidden = function(name, bufnr)
						return false
					end,
					sort = {
						{ "type", "asc" },
						{ "name", "asc" },
					},
				},
				float = {
					padding = 1,
					max_width = 60,
					max_height = 16,
					border = "rounded",
					win_options = {
						winblend = 0,
					},
					override = function(conf)
						return conf
					end,
				},

				preview = {
					max_width = 0.9,
					min_width = { 40, 0.4 },
					width = nil,
					max_height = 0.9,
					min_height = { 5, 0.1 },
					height = nil,
					border = "rounded",
					win_options = {
						winblend = 0,
					},
				},

				keymaps = {
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					["<C-s>"] = "actions.select_vsplit",
					["<C-h>"] = "actions.select_split",
					["<C-t>"] = "actions.select_tab",
					["<C-p>"] = "actions.preview",
					["<Esc>"] = "actions.close",
					["<C-l>"] = "actions.refresh",
					["<BS>"] = "actions.parent",
					["_"] = "actions.open_cwd",
					["`"] = "actions.cd",
					["~"] = "actions.tcd",
					["gs"] = "actions.change_sort",
					["g."] = "actions.toggle_hidden",
				},
			})

			vim.keymap.set("n", "<leader>to", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
		end,
	},
  ]]
	--

	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local api = require("nvim-tree.api")
			-- disable netrw at the very start of your init.lua
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			require("nvim-tree").setup({
				sort_by = "case_sensitive",
				view = {
					float = {
						enable = true,
					},
					adaptive_size = true,
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = true,
				},
			})

			local function create_split(direction)
				if direction == "left" then
					vim.cmd("set nosplitright")
					vim.cmd("vsplit")
					vim.cmd("set splitright")
				elseif direction == "right" then
					vim.cmd("set splitright")
					vim.cmd("vsplit")
				elseif direction == "down" then
					vim.cmd("set splitbelow")
					vim.cmd("split")
				elseif direction == "up" then
					vim.cmd("set nosplitbelow")
					vim.cmd("split")
					vim.cmd("set splitbelow")
				else
					print("Invalid direction: use the arrows ← ↑ ↓ →")
					return
				end

				api.tree.focus()
			end

			vim.keymap.set("n", "<leader>ts<Left>", function()
				create_split("left")
			end)
			vim.keymap.set("n", "<leader>ts<Right>", function()
				create_split("right")
			end)
			vim.keymap.set("n", "<leader>ts<Down>", function()
				create_split("down")
			end)
			vim.keymap.set("n", "<leader>ts<Up>", function()
				create_split("up")
			end)

			vim.keymap.set("n", "<leader>to", function()
				api.tree.focus()
			end)

			vim.keymap.set("n", "<leader>tc", function()
				api.tree.close()
			end)

			local prev = { new_name = "", old_name = "" } -- Prevents duplicate events
			vim.api.nvim_create_autocmd("User", {
				pattern = "NvimTreeSetup",
				callback = function()
					local events = api.events
					events.subscribe(events.Event.NodeRenamed, function(data)
						if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
							data = data
							Snacks.rename.on_rename_file(data.old_name, data.new_name)
						end
					end)
				end,
			})

			vim.cmd([[hi NvimTreeNormal guibg=NONE ctermbg=NONE]])
		end,
	},

	{
		"romgrk/barbar.nvim",
		config = function()
			require("barbar").setup({})

			local map = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }

			-- Move to previous/next
			map("n", "<leader>,", "<Cmd>BufferPrevious<CR>", opts)
			map("n", "<leader>.", "<Cmd>BufferNext<CR>", opts)
			-- Re-order to previous/next
			map("n", "<leader><", "<Cmd>BufferMovePrevious<CR>", opts)
			map("n", "<leader>>", "<Cmd>BufferMoveNext<CR>", opts)
			-- Goto buffer in position...
			map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
			map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
			map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
			map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
			map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
			map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
			map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
			map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
			map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
			map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
			-- Pin/unpin buffer
			map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
			-- Close buffer
			map("n", "<leader>bc", "<Cmd>BufferClose<CR>", opts)
			map("n", "<leader>ca", "<Cmd>BufferCloseAllButCurrent<CR>", opts)
			-- Wipeout buffer
			--                 :BufferWipeout
			-- Close commands
			--                 :BufferCloseAllButCurrent
			--                 :BufferCloseAllButPinned
			--                 :BufferCloseAllButCurrentOrPinned
			--                 :BufferCloseBuffersLeft
			--                 :BufferCloseBuffersRight
			-- Magic buffer-picking mode
			map("n", "<leader>bp", "<Cmd>BufferPick<CR>", opts)
			-- Sort automatically by...
			-- map("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
			-- map("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", opts)
			-- map("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
			-- map("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)

			-- Other:
			-- :BarbarEnable - enables barbar (enabled by default)
			-- :BarbarDisable - very bad command, should never be used
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
				},
				sections = {
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = {
						{
							"filename",
							path = 1,
							symbols = {
								modified = "●",
								readonly = "",
								unnamed = "[Unnamed]",
								newfile = "[New]",
							},
						},
					},
				},
			})
		end,
	},

	{
		"j-hui/fidget.nvim",
		version = "*",
		opts = {
			notification = {
				window = {
					winblend = 0,
				},
			},
		},
	},

	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				background_colour = "#000000",
			})
		end,
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},

			routes = {
				{
					filter = {
						event = "notify",
						find = "Content is not an image",
						kind = "warn",
					},
					opts = { skip = true },
				},
			},
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},

  --[[
	{
		"hat0uma/csvview.nvim",
		---@module "csvview"
		---@type CsvView.Options
		opts = {
			parser = { comments = { "#", "//" } },
			keymaps = {
				-- Text objects for selecting fields
				textobject_field_inner = { "if", mode = { "o", "x" } },
				textobject_field_outer = { "af", mode = { "o", "x" } },
				-- Excel-like navigation:
				-- Use <Tab> and <S-Tab> to move horizontally between fields.
				-- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
				-- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
				jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
				jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
				jump_next_row = { "<Enter>", mode = { "n", "v" } },
				jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
			},
		},
		cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
	},
  ]]--
}
