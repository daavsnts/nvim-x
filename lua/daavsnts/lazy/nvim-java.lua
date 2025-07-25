return {
  "nvim-java/nvim-java",
  config = function()
    require('lspconfig').jdtls.setup({
      settings = {
        java = {
          configuration = {
            runtimes = {
              {
                name = "JavaSE-21",
                path = "/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home",
                default = true,
              },
            },
          },
        },
      },
    })
  end,
}

