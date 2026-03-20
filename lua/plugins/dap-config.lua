local mason_path = vim.fn.stdpath("data") .. "\\mason\\packages\\netcoredbg\\netcoredbg"

local netcoredbg_adapter = {
    type = "executable",
    command = mason_path .. "\\netcoredbg.exe",
    args = { "--interpreter=vscode" },
}

return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")

            dap.adapters.netcoredbg = netcoredbg_adapter
            dap.adapters.coreclr = netcoredbg_adapter

            local dotnet = require("config.nvim-dap-dotnet")

            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "Launch .NET",
                    request = "launch",
                    program = function()
                        return dotnet.build_dll_path()
                    end,
                },
            }

            -- optional keymaps
            vim.keymap.set("n", "<F5>", dap.continue)
            vim.keymap.set("n", "<F10>", dap.step_over)
            vim.keymap.set("n", "<F11>", dap.step_into)
            vim.keymap.set("n", "<F12>", dap.step_out)
            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
        end,
    },

    {
        "igorlfs/nvim-dap-view",
        dependencies = { "mfussenegger/nvim-dap" },
        lazy = false,
        ---@type dapview.Config
        opts = {
            -- enable this if you want it to auto-open/close with sessions
            auto_toggle = true,
        },
    },
}
