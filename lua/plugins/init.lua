vim.pack.add({
    { src = "https://github.com/sainnhe/everforest" },
})

vim.g.everforest_enable_italic = true
vim.g.everforest_transparent_background = 2
vim.cmd.colorscheme("everforest")

require("plugins.snacks")
require("plugins.oil")
