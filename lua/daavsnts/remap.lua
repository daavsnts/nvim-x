vim.g.mapleader = " "

vim.keymap.set("v", "K", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "J", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")

--vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ bufnr = 0 })
end)

vim.keymap.set("v", "=", function()
	local start_pos = vim.api.nvim_buf_get_mark(0, "<")
	local end_pos = vim.api.nvim_buf_get_mark(0, ">")

	require("conform").format({
		range = {
			start = { start_pos[1], start_pos[2] },
			["end"] = { end_pos[1], end_pos[2] },
		},
		async = true,
		--lsp_fallback = true,
	})
end, { silent = true })

vim.keymap.set("n", "gd", function()
	vim.lsp.buf.definition()
end, opts)
vim.keymap.set("n", "gD", function()
	vim.lsp.buf.declaration()
end, opts)
vim.keymap.set("n", "gi", function()
	vim.lsp.buf.implementation()
end, opts)
vim.keymap.set("n", "go", function()
	vim.lsp.buf.type_definition()
end, opts)
vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover()
end, opts)
vim.keymap.set("n", "<leader>vws", function()
	vim.lsp.buf.workspace_symbol()
end, opts)
vim.keymap.set("n", "<leader>vd", function()
	vim.diagnostic.open_float()
end, opts)
vim.keymap.set("n", "<leader>vca", function()
	vim.lsp.buf.code_action()
end, opts)
vim.keymap.set("n", "<leader>vrr", function()
	vim.lsp.buf.references()
end, opts)
vim.keymap.set("n", "<leader>vrn", function()
	vim.lsp.buf.rename()
end, opts)
vim.keymap.set("i", "<C-h>", function()
	vim.lsp.buf.signature_help()
end, opts)
vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_next()
end, opts)
vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_prev()
end, opts)

vim.keymap.set("n", "<leader>w", "<C-W>")

vim.keymap.set("n", "<A-Up>", ":normal! 3k<CR>", { silent = true })
vim.keymap.set("n", "<A-Down>", ":normal! 3j<CR>", { silent = true })
--vim.keymap.set("n", "<A-Right>", ":normal! 10l<CR>")
--vim.keymap.set("n", "<A-Left>", ":normal! 10h<CR>")

vim.keymap.set("n", "<leader>y", '"*y')
vim.keymap.set("n", "<PageUp>", "<C-y>", { noremap = true, silent = true })
vim.keymap.set("n", "<PageDown>", "<C-e>", { noremap = true, silent = true })

-- Copy the current LSP error message to the clipboard
vim.keymap.set("n", "<leader>ce", function()
	local line = vim.fn.line(".")
	local messages = {}

	-- Get LSP diagnostics
	local lsp_diags = vim.diagnostic.get(0, { lnum = line - 1 })
	if lsp_diags and #lsp_diags > 0 then
		for _, diag in ipairs(lsp_diags) do
			table.insert(messages, diag.message)
		end
	end

	-- Get quickfix/location list errors on this line
	local function get_qf_msgs()
		local qflist = vim.fn.getqflist({ all = 1 }).items
		for _, item in ipairs(qflist) do
			if item.bufnr == vim.fn.bufnr("%") and item.lnum == line and item.text then
				table.insert(messages, item.text)
			end
		end
		local loclist = vim.fn.getloclist(0, { all = 1 }).items
		for _, item in ipairs(loclist) do
			if item.bufnr == vim.fn.bufnr("%") and item.lnum == line and item.text then
				table.insert(messages, item.text)
			end
		end
	end
	get_qf_msgs()

	if #messages > 0 then
		local all_msgs = table.concat(messages, "\n")
		vim.fn.setreg("+", all_msgs)
		print("Copied error(s) on the current line.")
	else
		print("No error found on the current line.")
	end
end, { noremap = true, silent = true })

-- last changes
vim.keymap.set("n", "<leader>la", "g;")
vim.keymap.set("n", "<leader>lA", "g,")
