return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		config = true,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local servers = require("plugins.lsp.servers")
			local on_attach = require("plugins.lsp.on_attach")
			local tools = require("plugins.lsp.tools")
			local ensure_installed = vim.tbl_keys(servers)
			vim.list_extend(ensure_installed, tools)
			require("plugins.lsp.diagnostics").setup()

			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)

			require("mason-tool-installer").setup({
				ensure_installed = ensure_installed,
				auto_update = false, -- avoid network slowdown for project opens
				run_on_start = true,
			})

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server_opts = servers[server_name]
						if type(server_opts) ~= "table" then
							server_opts = {}
						end

						server_opts.capabilities =
							vim.tbl_deep_extend("force", {}, capabilities, server_opts.capabilities or {})

						server_opts.on_attach = on_attach
						require("lspconfig")[server_name].setup(server_opts)
					end,
				},
			})
		end,
	},
	{ import = "plugins.lsp.conform" },
}
