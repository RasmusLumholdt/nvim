return {
  "folke/snacks.nvim",

  -- Lazy-load Snacks on first use of any of these keys
  keys = {
    {
      "<leader>lg",
      function()
        require("snacks").lazygit.open()
      end,
      mode = "n",
      desc = "Snacks: Lazygit",
    },
    {
      "<leader>t",
      function()
        require("snacks").picker.smart()
      end,
      mode = "n",
      desc = "Snacks: Smart picker",
    },
    {
      "<leader>/",
      function()
        require("snacks").picker.grep()
      end,
      mode = "n",
      desc = "Snacks: Grep",
    },
    {
      "<leader><space>",
      function()
        require("snacks").picker.buffers({
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
            list = {
              keys = {
                ["d"] = "bufdelete",
              },
            },
          },
          -- layout = "ivy",
        })
      end,
      mode = "n",
      desc = "Snacks: Buffers",
    },
    {
      "<leader>ss",
      function()
        require("snacks").picker.lsp_symbols()
      end,
      mode = "n",
      desc = "Snacks: LSP symbols",
    },
    {
      "<leader>ff",
      function()
        require("snacks").picker.files()
      end,
      mode = "n",
      desc = "Snacks: Files",
    },
    {
      "<leader>sS",
      function()
        require("snacks").picker.lsp_workspace_symbols()
      end,
      mode = "n",
      desc = "Snacks: Workspace symbols",
    },
    {
      "gd",
      function()
        require("snacks").picker.lsp_definitions({
          on_show = function()
            vim.cmd.stopinsert()
          end,
        })
      end,
      mode = "n",
      desc = "Snacks: LSP definitions",
    },
    {
      "gi",
      function()
        require("snacks").picker.lsp_definitions({
          on_show = function()
            vim.cmd.stopinsert()
          end,
        })
      end,
      mode = "n",
      desc = "Snacks: LSP implementations(?)",
    },
    {
      "gr",
      function()
        require("snacks").picker.lsp_references({
          on_show = function()
            vim.cmd.stopinsert()
          end,
        })
      end,
      mode = "n",
      desc = "Snacks: LSP references",
    },
    {
      "gy",
      function()
        require("snacks").picker.lsp_type_definitions()
      end,
      mode = "n",
      desc = "Snacks: LSP type defs",
    },
    -- This one does not use Snacks, but putting it here is fine if
    -- you don't care that it will also trigger loading Snacks.
    {
      "<leader>.",
      function()
        vim.lsp.buf.code_action()
      end,
      mode = "n",
      desc = "LSP code action",
    },
  },

  config = function()
    local Snacks = require("snacks")

    Snacks.setup({
      bigfile = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      lazygit = {
        enabled = true,
        configure = true,
      },
      statuscolumn = {
        left = { "mark", "sign" },
        right = { "fold", "git" },
        folds = {
          open = false,
          git_hl = false,
        },
        git = {
          patterns = { "GitSign", "MiniDiffSign" },
        },
        refresh = 50,
        enabled = true,
      },
      words = { enabled = true },
      picker = { enabled = true },
    })

    -- Your custom statuscolumn (note: this may override Snacks' own)
    vim.opt.statuscolumn =
      "%=%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}%=%s"
  end,
}
