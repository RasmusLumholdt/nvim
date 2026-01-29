return {
    {
        'nvim-mini/mini.icons',
        lazy = false,
        config = function()
            require("mini.icons").setup()
        end

    },

    {
        "echasnovski/mini.files",
        lazy = false,
        keys = {
            {
                "<leader>E",
                function()
                    require("mini.files").open()
                end,
                mode = "n",
                desc = "Mini Files",
            },
            {
                "<leader>e",
                function()
                    local MiniFiles = require("mini.files")
                    local _ = MiniFiles.close()
                        or MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
                    vim.schedule(function()
                        MiniFiles.reveal_cwd()
                    end)
                end,
            }
        },
        config = function()
            require("mini.files").setup({})
        end,
    }
}
