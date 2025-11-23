vim.pack.add({
    { src = "https://github.com/sainnhe/everforest" },
})

vim.g.everforest_enable_italic = true
vim.cmd.colorscheme("everforest")

require("plugins.snacks")
