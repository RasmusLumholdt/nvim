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
    statuscolumn = {
        left = { "mark", "sign" }, -- priority of signs on the left (high to low)
        right = { "fold", "git" }, -- priority of signs on the right (high to low)
        folds = {
            open = false,    -- show open fold icons
            git_hl = false,  -- use Git Signs hl for fold icons
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

vim.keymap.set("n", "<leader>e", Snacks.explorer)
vim.keymap.set("n", "<leader><space>", Snacks.picker.smart)
vim.keymap.set("n", "<leader>ff", function()
    Snacks.picker.files()
end)

vim.opt.statuscolumn = "%=%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}%=%s"
