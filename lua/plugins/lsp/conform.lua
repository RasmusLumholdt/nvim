return {
	"stevearc/conform.nvim",
	dependencies = { "williamboman/mason.nvim" },
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	config = function()
		local tools = require("plugins.lsp.tools")

		-- Helper: check if a tool is executable
		local function is_executable(name)
			return vim.fn.executable(name) == 1
		end

		-- Dynamically build formatter conditions based on installed tools
		local formatters = {
			dotnet_format = {
				command = "dotnet",
				args = { "format", "--include", "$FILENAME" },
				stdin = false, -- dotnet format works on files directly, not stdin
				condition = function(ctx)
					if vim.fn.executable("dotnet") ~= 1 then
						return false
					end
					-- Only run if inside a .NET project (e.g. has .sln, .csproj, or .vbproj in parent dirs)
					local found = vim.fs.find(
						{ "*.sln", "*.csproj", "*.vbproj" },
						{ upward = true, stop = vim.loop.os_homedir(), path = ctx.dirname }
					)
					return #found > 0
				end,
			},
		}
		for _, tool in ipairs(tools) do
			formatters[tool] = {
				condition = function()
					return is_executable(tool)
				end,
			}
		end

		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				javascriptreact = { { "prettierd", "prettier" } },
				typescriptreact = { { "prettierd", "prettier" } },
				json = { { "prettierd", "prettier" } },
				yaml = { { "prettierd", "prettier" } },
				markdown = { { "prettierd", "prettier" } },
				sh = { "shfmt" },
				python = { { "ruff_format", "black" } },
				terraform = { "terraform_fmt" },
				make = { "checkmake" },
				csharp = { "dotnet-format" },
			},
			-- register only formatters that exist in PATH
			formatters = formatters,
			format_on_save = {
				lsp_fallback = true,
			},
		})
	end,
}
