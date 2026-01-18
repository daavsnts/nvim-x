vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.podspec", "Podfile" },
	command = "set filetype=ruby",
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	pattern = "*",
	callback = function()
		vim.cmd("silent! checktime")
	end,
})

vim.api.nvim_create_user_command("Fcmd", function(opts)
	vim.fn.jobstart(table.concat(opts.fargs, " "), {
		detach = true,
	})
end, { nargs = "+" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "sql",
  callback = function()
    vim.keymap.set("i", "<Left>", function()
      vim.fn["sqlcomplete#DrillOutOfColumns"]()
    end, { silent = true, buffer = true })

    vim.keymap.set("i", "<Right>", function()
      vim.fn["sqlcomplete#DrillIntoTable"]()
    end, { silent = true, buffer = true })
  end,
})
