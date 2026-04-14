vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Build hooks for plugins that need post-install/update actions
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
            vim.cmd("TSUpdate")
        end
    end,
})

vim.pack.add({
    -- Dependencies first
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",

    -- UI
    "https://github.com/rebelot/kanagawa.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    "https://github.com/letieu/wezterm-move.nvim",
    "https://github.com/sphamba/smear-cursor.nvim",

    -- Editor
    "https://github.com/folke/snacks.nvim",
    "https://github.com/nvim-mini/mini.icons",
    "https://github.com/echasnovski/mini.files",
    "https://github.com/jiaoshijie/undotree",
    "https://github.com/TheNoeTrevino/haunt.nvim",

    -- LSP / Completion
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/folke/lazydev.nvim",
    "https://github.com/seblyng/roslyn.nvim",
    "https://github.com/stevearc/conform.nvim",
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.x") },

    -- Treesitter
    "https://github.com/nvim-treesitter/nvim-treesitter",

    -- Git (loaded eagerly, but neogit is only triggered via keymap)
    "https://github.com/sindrets/diffview.nvim",
    "https://github.com/NeogitOrg/neogit",
})

require("config")
