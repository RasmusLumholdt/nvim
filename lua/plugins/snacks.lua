vim.pack.add({ "https://github.com/folke/snacks.nvim" })
local Snacks = require("snacks")
Snacks.setup({
    bigfile = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
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
})

vim.keymap.set("n", "<leader>lg", Snacks.lazygit.open)
vim.keymap.set("n", "<leader>t", Snacks.picker.smart)
-- LSP (gX)
vim.keymap.set("n", "gd", Snacks.picker.lsp_definitions)
vim.keymap.set("n", "gi", Snacks.picker.lsp_implementations)
vim.keymap.set("n", "gr", Snacks.picker.lsp_references)
vim.keymap.set("n", "gy", Snacks.picker.lsp_type_definitions)
vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action)

vim.keymap.set("n", "<leader>ff", Snacks.picker.files)

vim.opt.statuscolumn = "%=%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}%=%s"
