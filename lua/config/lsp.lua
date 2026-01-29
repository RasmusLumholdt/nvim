vim.lsp.inlay_hint.enable(true)

vim.diagnostic.config({
    virtual_text = true,
    jump = { float = true },
})

-- Disable unwanted auto-enabled servers
vim.lsp.enable("vue_ls", false)
vim.lsp.enable("volar", false)
vim.lsp.enable("pyright", false)
vim.lsp.enable("stylua", false)

-- vim.api.nvim_create_autocmd("LspAttach", {
--     group = vim.api.nvim_create_augroup("my.lsp", {}),
--     callback = function(args)
--         local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--
--         if
--             not client:supports_method("textDocument/willSaveWaitUntil")
--             and client:supports_method("textDocument/formatting")
--         then
--             vim.api.nvim_create_autocmd("BufWritePre", {
--                 group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
--                 buffer = args.buf,
--                 callback = function()
--                     vim.lsp.buf.format({
--                         bufnr = args.buf,
--                         id = client.id,
--                         timeout_ms = 1000,
--                     })
--                 end,
--             })
--         end
--     end,
-- })

-- C# / Roslyn
vim.lsp.config("roslyn", {
    on_attach = function()
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

-- Lua
vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            hint = { enable = true },
            telemetry = { enable = false },
        },
    },
})

vim.lsp.enable("lua_ls")

-- TypeScript/JavaScript/React
vim.lsp.config("ts_ls", {
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    root_markers = { "tsconfig.json", "package.json" },
})

vim.lsp.enable("ts_ls")
