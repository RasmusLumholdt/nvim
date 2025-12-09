vim.pack.add({
    { src = "https://github.com/sainnhe/everforest" },
    { src = "https://github.com/sphamba/smear-cursor.nvim" },
})

vim.g.everforest_enable_italic = true
vim.g.everforest_transparent_background = 2
vim.cmd.colorscheme("everforest")

require("smear_cursor").setup({})

require("plugins.snacks")
require("plugins.minifiles")
require("plugins.dap-config")
