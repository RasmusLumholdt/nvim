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
		cmd = { "OmniSharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
		enable_roslyn_analyzers = true,
		organize_imports_on_format = true,
		enable_import_completion = true,
		settings = {
			FormattingOptions = {
				-- optionally, let dotnet format handle formatting
				EnableEditorConfigSupport = true,
				OrganizeImports = true,
			},
		},
	},
}
