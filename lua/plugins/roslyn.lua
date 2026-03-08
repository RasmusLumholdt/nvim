return {
    "seblyng/roslyn.nvim",
    lazy = false, -- or event = "VeryLazy" if you want, but keep it simple first
    config = function()
        -- Set MSBuild environment for .NET Framework project support
        -- This allows Roslyn LSP to load legacy .NET Framework projects (net472, etc.)
        vim.env.MSBUILD_EXE_PATH =
        "C:\\Program Files\\Microsoft Visual Studio\\2022\\Professional\\MSBuild\\Current\\Bin\\MSBuild.exe"
        vim.env.VSINSTALLDIR = "C:\\Program Files\\Microsoft Visual Studio\\2022\\Professional\\"

        require("roslyn").setup({
            filewatching = "auto",
            choose_target = nil,
            -- ignore_target = nil,
            broad_search = true,
            lock_target = true,
            silent = false,
        })
    end,
}
