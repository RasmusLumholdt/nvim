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
	omnisharp = {
		cmd = {
			"OmniSharp",
			"--languageserver",
			"--hostPID",
			tostring(vim.fn.getpid()),
		},
		root_dir = function(fname)
			return require("lspconfig.util").root_pattern("*.sln", "*.csproj")(fname)
				or require("lspconfig.util").find_git_ancestor(fname)
		end,
		enable_roslyn_analyzers = true,
		enable_import_completion = true,
		organize_imports_on_format = true,
	},
}
