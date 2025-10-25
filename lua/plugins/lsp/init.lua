return {
	{
		"neovim/nvim-lspconfig",
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

			require("plugins.lsp.diagnostics").setup()

			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)

			local ensure_installed = vim.tbl_keys(servers)
			vim.list_extend(ensure_installed)
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
  handlers = {
    function(server_name)
      local server_opts = servers[server_name]
      if type(server_opts) ~= "table" then
        server_opts = {}
      end

      server_opts.capabilities = vim.tbl_deep_extend(
        "force",
        {},
        capabilities,
        server_opts.capabilities or {}
      )

      require("lspconfig")[server_name].setup(server_opts)
    end,
  },
})	
		end,
	},
}
