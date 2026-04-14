-- Theme
require("kanagawa").setup({
    overrides = function(colors)
        return {
            -- Float backgrounds
            NormalFloat   = { bg = colors.theme.ui.bg },
            FloatBorder   = { bg = colors.theme.ui.bg },
            FloatTitle    = { bg = colors.theme.ui.bg },
            FloatFooter   = { bg = colors.theme.ui.bg },
            -- Completion menu: neutral background
            Pmenu         = { fg = colors.theme.ui.fg, bg = colors.theme.ui.bg },
            PmenuSel      = { fg = "NONE", bg = colors.theme.ui.bg_p2 },
            PmenuKind     = { fg = colors.theme.ui.fg_dim, bg = colors.theme.ui.bg },
            PmenuKindSel  = { fg = colors.theme.ui.fg_dim, bg = colors.theme.ui.bg_p2 },
            PmenuExtra    = { fg = colors.theme.ui.special, bg = colors.theme.ui.bg },
            PmenuExtraSel = { fg = colors.theme.ui.special, bg = colors.theme.ui.bg_p2 },
            PmenuSbar     = { bg = colors.theme.ui.bg_p1 },
            PmenuThumb    = { bg = colors.theme.ui.bg_p2 },
            -- Completion menu border: match editor bg, neutral border color
            BlinkCmpMenuBorder    = { fg = colors.theme.ui.float.fg_border, bg = colors.theme.ui.bg },
            -- Match highlighting: orange instead of blue
            CmpItemAbbrMatch      = { fg = colors.theme.syn.constant },
            CmpItemAbbrMatchFuzzy = { fg = colors.theme.syn.constant },
            BlinkCmpLabelMatch    = { fg = colors.theme.syn.constant },
        }
    end,
})
vim.cmd.colorscheme("kanagawa-dragon")

-- Smear cursor
require("smear_cursor").setup({})

-- Wezterm pane navigation
vim.keymap.set("n", "<C-h>", function() require("wezterm-move").move("h") end)
vim.keymap.set("n", "<C-j>", function() require("wezterm-move").move("j") end)
vim.keymap.set("n", "<C-k>", function() require("wezterm-move").move("k") end)
vim.keymap.set("n", "<C-l>", function() require("wezterm-move").move("l") end)

-- Render Markdown
require("render-markdown").setup({})

-- Lualine
local lualine = require("lualine")

lualine.setup({
    options = {
        theme = "kanagawa",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {
            {
                function()
                    local clients = vim.lsp.get_clients({ bufnr = 0 })
                    if #clients == 0 then return "" end
                    local names = vim.iter(clients):map(function(c) return c.name end):totable()
                    return " " .. table.concat(names, ", ")
                end,
            },
            "encoding",
            "fileformat",
            "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
})
