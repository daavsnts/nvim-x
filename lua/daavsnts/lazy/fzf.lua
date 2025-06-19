return {
  {
    "junegunn/fzf.vim",
    dependencies = {
      {
        "junegunn/fzf",
        dir = "/usr/local/Cellar/fzf/0.57.0",
        build = "./install --all"
      }
    },
    config = function()
      vim.keymap.set("n", "<leader>ag", ":Ag <CR>")
      vim.keymap.set("n", "<leader>rg", ":Rg <CR>")
    end
  }
}
