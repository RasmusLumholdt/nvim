return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufWritePost", "InsertLeave" },
	dependencies = { "williamboman/mason.nvim" },
	config = function()
		local tools = require("plugins.lsp.tools")

		-- check if a binary is available
		local function is_executable(name)
			return vim.fn.executable(name) == 1
		end

		local lint = require("lint")

		-- define which linters to use per filetype
		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			python = { "ruff" },
			sh = { "shellcheck" },
			make = { "checkmake" },
		}

		-- prune linters that aren't actually installed
		for ft, linters in pairs(lint.linters_by_ft) do
			lint.linters_by_ft[ft] = vim.tbl_filter(is_executable, linters)
		end

		-- run lint automatically on specific events
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			callback = function()
				local ft = vim.bo.filetype
				if lint.linters_by_ft[ft] and #lint.linters_by_ft[ft] > 0 then
					lint.try_lint()
				end
			end,
		})
	end,
}
