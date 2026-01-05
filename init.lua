vim.pack.add({ "https://github.com/zuqini/zpack.nvim" })

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("zpack").setup({})
require('config')

-- vim.pack.add({
--
--     "https://github.com/nvim-treesitter/nvim-treesitter",
--     "https://github.com/neovim/nvim-lspconfig",
--     "https://github.com/mason-org/mason.nvim",
--     "https://github.com/mason-org/mason-lspconfig.nvim",
--     "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
--     "https://github.com/saghen/blink.cmp",
--     "https://github.com/seblyng/roslyn.nvim",
--     "https://github.com/folke/lazydev.nvim",
--
--     --markdownreader + dependencies
--     -- 'https://github.com/nvim-mini/mini.nvim',            -- if you use the mini.nvim suite
--     "https://github.com/nvim-mini/mini.icons", -- if you use standalone mini plugins
--     "https://github.com/MeanderingProgrammer/render-markdown.nvim",
-- })
--
-- require("render-markdown").setup({
--     completions = { lsp = { enabled = true } },
-- })
--
-- require("lazydev").setup()
-- vim.lsp.config("lua_ls", {
--     settings = {
--         Lua = {
--             runtime = {
--                 -- Tell the language server which version of Lua you're using
--                 -- (most likely LuaJIT in the case of Neovim)
--                 version = "LuaJIT",
--             },
--             hint = { enable = true },
--             -- diagnostics = {
--             --     -- Get the language server to recognize the `vim` global
--             --     globals = {
--             --         "vim",
--             --         "require",
--             --     },
--             -- },
--             -- workspace = {
--             --     -- Make the server aware of Neovim runtime files
--             --     library = vim.env.VIMRUNTIME
--             -- },
--             -- Do not send telemetry data containing a randomized but unique identifier
--             telemetry = {
--                 enable = false,
--             },
--         },
--     },
-- })
