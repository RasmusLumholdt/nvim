vim.lsp.inlay_hint.enable(true)

vim.diagnostic.config({
    virtual_text = true,
    jump = { float = true },
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my.lsp", {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        if
            not client:supports_method("textDocument/willSaveWaitUntil")
            and client:supports_method("textDocument/formatting")
        then
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({
                        bufnr = args.buf,
                        id = client.id,
                        timeout_ms = 1000,
                    })
                end,
            })
        end
    end,
})

--c# aka roslyn
vim.lsp.config("roslyn", {
    on_attach = function()
        -- this runs *when Roslyn attaches*, in addition to your LspAttach autocmd
        print("Roslyn attached")
    end,
    settings = {
        ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
        },
        ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
        },
    },
})

local lua_ls = vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            hint = { enable = true },
            telemetry = { enable = false },
        },
    },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function(args)
        vim.lsp.start(lua_ls, { bufnr = args.buf })
    end,
})

local vtsls = vim.lsp.config("vtsls", {
    settings = {
        -- TS/JS inlay hints etc.
    },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    callback = function(args)
        vim.lsp.start(vtsls, { bufnr = args.buf })
    end,
})

local volar = vim.lsp.config("volar", {
    -- vue-specific settings if you want
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "vue",
    callback = function(args)
        vim.lsp.start(volar, { bufnr = args.buf })
    end,
})
