return {
  "stevearc/conform.nvim",
  dependencies = { "williamboman/mason.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "ConformInfo" },
  config = function()
    local tools = require("plugins.lsp.tools")

    -- check if a tool is executable
    local function is_executable(name)
      return vim.fn.executable(name) == 1
    end

    -- Define custom formatters
    local formatters = {
      dotnet_format = {
        command = "dotnet",
        args = { "format", "--include", "$FILENAME" },
        stdin = false,
        condition = function(ctx)
          if vim.fn.executable("dotnet") ~= 1 then
            return false
          end
          -- run only in .NET projects
          local found = vim.fs.find(
            { "*.sln", "*.csproj", "*.vbproj" },
            { upward = true, stop = vim.loop.os_homedir(), path = ctx.dirname }
          )
          return #found > 0
        end,
      },
    }

    -- Add conditional checks for tools.lua binaries
    for _, tool in ipairs(tools) do
      formatters[tool] = {
        condition = function()
          return is_executable(tool)
        end,
      }
    end

    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd", "prettier" },
        typescript = { "prettierd", "prettier" }
                ,javascriptreact = { "prettierd", "prettier" },
        typescriptreact = { "prettierd", "prettier" },
        json = { "prettierd", "prettier" },
        yaml = { "prettierd", "prettier" },
        markdown = { "prettierd", "prettier" },
        sh = { "shfmt" },
        python = { "ruff_format", "black" },
        terraform = { "terraform_fmt" },
        make = { "checkmake" },
        csharp = { "dotnet_format" },
      },
      stop_after_first = true, -- new behavior for fallback chains
      formatters = formatters,
      format_on_save = {
        lsp_fallback = true,
      },
    })

    -- guarantee formatting on save fires
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        require("conform").format({
          bufnr = args.buf,
          lsp_fallback = true,
        })
      end,
    })
  end,
}
