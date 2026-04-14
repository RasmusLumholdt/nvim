-- Neogit (lazy-loaded via keymap -- require() triggers load on first use)
vim.keymap.set("n", "<leader>gg", function()
    require("neogit").setup({})
    require("neogit").open()
    -- After first load, remap to skip setup
    vim.keymap.set("n", "<leader>gg", function()
        require("neogit").open()
    end, { desc = "Show Neogit UI" })
end, { desc = "Show Neogit UI" })
