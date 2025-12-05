vim.pack.add({ "https://github.com/nvim-mini/mini.files" })

require("mini.files").setup({
})
vim.keymap.set("n", "<leader>e", MiniFiles.open, { desc = "Open parent directory" })
