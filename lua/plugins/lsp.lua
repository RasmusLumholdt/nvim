-- Mason (must be set up before mason-lspconfig and mason-tool-installer)
require("mason").setup({
    registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
    },
    ensure_installed = {
        "roslyn",
        "netcoredbg",
    },
})

require("mason-lspconfig").setup({
    ensure_installed = {},
})

require("mason-tool-installer").setup({
    ensure_installed = {
        "roslyn",
        "lua_ls",
        "stylua",
        "jq",
    },
    run_on_start = false,
    auto_update = false,
})

-- Lazydev (Lua development for Neovim)
require("lazydev").setup()

-- Roslyn (C# LSP)
vim.env.MSBUILD_EXE_PATH =
    "C:\\Program Files\\Microsoft Visual Studio\\2022\\Professional\\MSBuild\\Current\\Bin\\MSBuild.exe"
vim.env.VSINSTALLDIR = "C:\\Program Files\\Microsoft Visual Studio\\2022\\Professional\\"

require("roslyn").setup({
    filewatching = "auto",
    choose_target = nil,
    broad_search = true,
    lock_target = true,
    silent = false,
})

-- Conform (formatting)
require("conform").setup({
    formatters_by_ft = {
        javascript = { "prettierd", "prettier", stop_after_first = true },
        json = { "jq" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})

-- Blink completion (lazy-loaded on InsertEnter)
vim.api.nvim_create_autocmd("InsertEnter", {
    once = true,
    callback = function()
        require("blink.cmp").setup({
            fuzzy = { implementation = "prefer_rust_with_warning" },
            signature = { enabled = true },
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
            sources = {
                default = { "lsp" },
            },
        })
    end,
})

-- Treesitter
require("nvim-treesitter")
vim.api.nvim_create_autocmd("User", {
    pattern = "TSInstallFinished",
    once = true,
    callback = function() end,
})
local ts = require("nvim-treesitter")
ts.install({ "elixir", "heex", "c_sharp" })
