return {
    "seblyng/roslyn.nvim",
    lazy = false, -- or event = "VeryLazy" if you want, but keep it simple first
    config = function()
        require("roslyn").setup({
            filewatching = "auto",
            choose_target = nil,
            ignore_target = nil,
            broad_search = false,
            lock_target = false,
            silent = false,
        })
    end,
}
