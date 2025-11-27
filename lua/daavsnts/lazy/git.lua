return {
	{
		"tpope/vim-fugitive",
	},
	{
		"f-person/git-blame.nvim",
		event = "VeryLazy",
		opts = {
			enabled = function()
				local ft = vim.bo.filetype
				return ft ~= "netrw" and ft ~= "NvimTree"
			end,
			message_template = " <summary> • <date> • <author> • <<sha>>",
			date_format = "%d-%m-%Y %H:%M:%S",
			virtual_text_column = 1,
		},
	},
}
