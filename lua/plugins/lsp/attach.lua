local M = {}

function M.setup()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspAttachKeymaps", { clear = true }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local bufnr = args.buf

      -- Only set these for omnisharp (optional; drop this if you want all servers)
      if client.name ~= "omnisharp" then
        return
      end

      local function buf_map(mode, keys, func, desc)
        vim.keymap.set(mode, keys, func, {
          buffer = bufnr,
          desc = desc and ("LSP: " .. desc) or nil,
          noremap = true,
          silent = true,
        })
      end

      print("LspAttach:", client.name, bufnr)

      buf_map("n", "<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
      buf_map({ "n", "x" }, "<leader>.", vim.lsp.buf.code_action, "[C]ode [A]ction")

      if client.server_capabilities.documentFormattingProvider then
        buf_map("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, "[F]ormat")
      end
    end,
  })
end

return M
