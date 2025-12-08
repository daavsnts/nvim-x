return {
	"eandrju/cellular-automaton.nvim",
	config = function()
		vim.keymap.set("n", "<leader>mir", "<cmd>CellularAutomaton make_it_rain<CR>")
	end,
}
