return {
    {
        'nvim-mini/mini.icons',
        lazy = false,
        config = function()
            require("mini.icons").setup()
        end

    },

{
  "echasnovski/mini.files",
  lazy = false,
  keys = {
    {
      "<leader>e",
      function()
        require("mini.files").open()
      end,
      mode = "n",
      desc = "Mini Files",
    },
  },
  config = function()
    require("mini.files").setup({})
  end,
}
}
