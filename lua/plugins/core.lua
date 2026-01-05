return {
    {
        "sainnhe/everforest",
        lazy = false,
        config = function()
            vim.g.everforest_enable_italic = true
            vim.g.everforest_transparent_background = 2
            vim.cmd.colorscheme("everforest")
        end,
    },
    {
        "sphamba/smear-cursor.nvim",
        lazy = false,
        config = function()
            require("smear_cursor").setup({})
        end,
    },
}
