return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        local ts = require("nvim-treesitter");

        ts.install({ "elixir", 'heex', 'c_sharp' })
    end,
}
