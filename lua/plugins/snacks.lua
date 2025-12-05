vim.pack.add({ "https://github.com/folke/snacks.nvim" })
local Snacks = require("snacks")
Snacks.setup({
    bigfile = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    lazygit = { enabled = true, configure = true },
    statuscolumn = {
        left = { "mark", "sign" }, -- priority of signs on the left (high to low)
        right = { "fold", "git" }, -- priority of signs on the right (high to low)
        folds = {
            open = false,          -- show open fold icons
            git_hl = false,        -- use Git Signs hl for fold icons
        },
        git = {
            -- patterns to match Git signs
            patterns = { "GitSign", "MiniDiffSign" },
        },
        refresh = 50, -- refresh at most every 50ms
        enabled = true,
    },
    words = { enabled = true },
    picker = { enabled = true },
})

vim.keymap.set("n", "<leader>lg", Snacks.lazygit.open)

vim.keymap.set("n", "<leader>t", Snacks.picker.smart)
vim.keymap.set("n", "<leader>/", Snacks.picker.grep)
vim.keymap.set("n", "<leader><space>", function()
    Snacks.picker.buffers({
        -- I always want my buffers picker to start in normal mode
        on_show = function()
            vim.cmd.stopinsert()
        end,
        finder = "buffers",
        format = "buffer",
        hidden = false,
        unloaded = true,
        current = true,
        sort_lastused = true,
        win = {
            input = {
                keys = {
                    ["d"] = "bufdelete",
                },
            },
            list = { keys = { ["d"] = "bufdelete" } },
        },
        -- In case you want to override the layout for this keymap
        -- layout = "ivy",
    })
end)
vim.keymap.set("n", "<leader>ss", Snacks.picker.lsp_symbols)
vim.keymap.set("n", "<leader>ff", Snacks.picker.files)

vim.keymap.set("n", "<leader>sS", Snacks.picker.lsp_workspace_symbols)
-- LSP (gX)
vim.keymap.set("n", "gd", function()
    Snacks.picker.lsp_definitions({
        on_show = function()
            vim.cmd.stopinsert()
        end,

    })
end)

vim.keymap.set("n", "gi", function()
    Snacks.picker.lsp_definitions({
        on_show = function()
            vim.cmd.stopinsert()
        end,

    })
end)

vim.keymap.set("n", "gr", function()
    Snacks.picker.lsp_references({
        on_show = function()
            vim.cmd.stopinsert()
        end,

    })
end)

vim.keymap.set("n", "gy", Snacks.picker.lsp_type_definitions)
vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action)

vim.opt.statuscolumn = "%=%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}%=%s"
