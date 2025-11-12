local tb = require("telescope.builtin")

local function buf_map(buf, mode, keys, func, desc)
	vim.keymap.set(mode, keys, func, { buffer = buf, desc = "LSP: " .. desc })
end

local M = function(client, bufnr)
	buf_map(bufnr, "n", "gd", tb.lsp_definitions, "[G]oto [D]efinition")
	buf_map(bufnr, "n", "gu", tb.lsp_references, "[G]oto [U]se")
	buf_map(bufnr, "n", "gr", tb.lsp_references, "[G]oto [R]eferences")
	buf_map(bufnr, "n", "gI", tb.lsp_implementations, "[G]oto [I]mplementation")
	buf_map(bufnr, "n", "<leader>D", tb.lsp_type_definitions, "Type [D]efinition")
	buf_map(bufnr, "n", "<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	buf_map(bufnr, { "n", "x" }, "<leader>.", vim.lsp.buf.code_action, "[C]ode [A]ction")

	if client.server_capabilities.documentFormattingProvider then
		buf_map(bufnr, "n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, "[F]ormat")
	end

	local group = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
	if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			buffer = bufnr,
			group = group,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			buffer = bufnr,
			group = group,
			callback = vim.lsp.buf.clear_references,
		})
	end

	if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
		buf_map(bufnr, "n", "<leader>lh", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
		end, "[T]oggle Inlay [H]ints")
	end
end

return M
