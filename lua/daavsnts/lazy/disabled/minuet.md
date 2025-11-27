return {
	{
		"milanglacier/minuet-ai.nvim",
		config = function()
			require("minuet").setup({
				provider = "gemini",
				provider_options = {
					gemini = {
						model = "gemini-2.0-flash",
						stream = true,
						api_key = "GEMINI_API_KEY",
						end_point = "https://generativelanguage.googleapis.com/v1beta/models",
						optional = {},
					},
				},
				virtualtext = {
					auto_trigger_ft = {},
					keymap = {
						accept = "<S-Tab>",
					},
				},
			})
		end,
	},
}
