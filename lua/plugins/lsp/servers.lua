local lspconfig = require("lspconfig")
local util = require("lspconfig.util")
local on_attach = require("plugins.lsp.on_attach")

return {
	gopls = {},
	pyright = {
		settings = {
			python = {
				analysis = { typeCheckingMode = "off" },
			},
		},
	},
	ts_ls = {},
	lua_ls = {
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				workspace = {
					checkThirdParty = false,
					library = {
						"${3rd}/luv/library",
						unpack(vim.api.nvim_get_runtime_file("", true)),
					},
				},
				completion = { callSnippet = "Replace" },
				telemetry = { enable = false },
				diagnostics = { disable = { "missing-fields" } },
			},
		},
	},
}
