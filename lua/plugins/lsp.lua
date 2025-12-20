return {
  -- 1. mason core
  {
    "mason-org/mason.nvim",
    lazy = false,
    priority = 1000, -- run this config first
    config = function()
      require("mason").setup({})
    end,
  },

  -- 2. mason-lspconfig (depends on mason)
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    priority = 900, -- after mason
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          -- add more servers
        },
      })
    end,
  },

  -- 3. mason-tool-installer (depends on mason)
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    priority = 800, -- after mason as well
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- tools, not LSP servers, usually:
          "stylua",
        },
        -- optional:
        run_on_start = false,
        auto_update = false,
      })
    end,
  },
}
