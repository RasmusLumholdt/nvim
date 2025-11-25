vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.keymaps")
require("core.options")
require("plugins")

vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
    { src = "https://github.com/saghen/blink.cmp",                         version = vim.version.range("^1") },
    { src = "https://github.com/folke/lazydev.nvim" },
})

require("mason").setup({
    registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
    },
})
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
    ensure_installed = {
        "lua_ls",
        "stylua",
    },
})

require("lazydev").setup()
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            -- diagnostics = {
            --     -- Get the language server to recognize the `vim` global
            --     globals = {
            --         "vim",
            --         "require",
            --     },
            -- },
            -- workspace = {
            --     -- Make the server aware of Neovim runtime files
            --     library = vim.env.VIMRUNTIME
            -- },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my.lsp", {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        -- if client:supports_method("textDocument/implementation") then
        --     -- Create a keymap for vim.lsp.buf.implementation ...
        -- end

        -- Auto-format ("lint") on save.
        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
        if
            not client:supports_method("textDocument/willSaveWaitUntil")
            and client:supports_method("textDocument/formatting")
        then
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end,
})

vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
})

require("blink.cmp").setup({
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true },
    -- keymap = {
    --     preset = "default",
    --     ["<C-space>"] = {},
    --     ["<C-p>"] = {},
    --     ["<Tab>"] = {},
    --     ["<S-Tab>"] = {},
    --     ["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
    --     ["<C-n>"] = { "select_and_accept" },
    --     ["<C-k>"] = { "select_prev", "fallback" },
    --     ["<C-j>"] = { "select_next", "fallback" },
    --     ["<C-b>"] = { "scroll_documentation_down", "fallback" },
    --     ["<C-f>"] = { "scroll_documentation_up", "fallback" },
    --     ["<C-l>"] = { "snippet_forward", "fallback" },
    --     ["<C-h>"] = { "snippet_backward", "fallback" },
    --     -- ["<C-e>"] = { "hide" },
    -- },

    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
    },

    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
        },
    },

    cmdline = {
        keymap = {
            preset = "inherit",
        },
    },

    sources = { default = { "lsp" } },
})
