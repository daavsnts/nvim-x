return {
	"chrisgrieser/nvim-spider",
	config = function()
		vim.keymap.set({ "n", "o", "x" }, "<A-Right>", "<cmd>lua require('spider').motion('w')<CR>")
		vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>")
		vim.keymap.set({ "n", "o", "x" }, "<A-Left>", "<cmd>lua require('spider').motion('b')<CR>")
	end,
}
