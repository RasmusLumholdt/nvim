local M = function(client, bufnr)
	-- Debug: see that this runs
	print("LSP on_attach:", client.name, bufnr)

	local function buf_map(mode, keys, func, desc)
		vim.keymap.set(mode, keys, func, {
			buffer = bufnr,
			desc = desc and ("LSP: " .. desc) or nil,
			noremap = true,
			silent = true,
		})
	end

	-- Code actions / rename
	buf_map("n", "<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	buf_map({ "n", "x" }, "<leader>.", function()
		vim.lsp.buf.code_action()
	end, "[C]ode [A]ction")

	-- Formatting
	if client.server_capabilities.documentFormattingProvider then
		buf_map("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, "[F]ormat")
	end

	-- Highlights
	if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
		local group = vim.api.nvim_create_augroup("lsp-highlight-" .. bufnr, { clear = true })

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

	-- Inlay hints (if available)
	if vim.lsp.inlay_hint and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
		buf_map("n", "<leader>lh", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
		end, "[T]oggle Inlay [H]ints")
	end
end

return M
