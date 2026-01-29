return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
	},
	{
		"mason-org/mason.nvim",
		lazy = false,
		priority = 1000, -- run this config first
		config = function()
			require("mason").setup({
				registries = {
					"github:mason-org/mason-registry",
					"github:Crashdummyy/mason-registry",
				},
				ensure_installed = {
					"roslyn",
					-- "lua_ls",
				},
			})
		end,
	},

	{
		"mason-org/mason-lspconfig.nvim",
		lazy = false,
		priority = 900, -- after mason
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					-- add more servers
				},
			})
		end,
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = false,
		priority = 800, -- after mason as well
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"roslyn",
					"lua_ls",
					-- tools, not LSP servers, usually:
					"stylua",
					"jq",
				},
				-- optional:
				run_on_start = false,
				auto_update = false,
			})
		end,
	},
}
