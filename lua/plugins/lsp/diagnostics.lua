local M = {}

M.setup = function()
  vim.diagnostic.config({
    virtual_text = { prefix = "●" },
    float = { border = "rounded", source = "always" },
    severity_sort = true,
  })
end

return M
