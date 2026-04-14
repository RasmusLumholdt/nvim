-- Mini icons
require("mini.icons").setup()

-- Mini files
require("mini.files").setup({})
vim.keymap.set("n", "<leader>E", function()
	require("mini.files").open()
end, { desc = "Mini Files" })
vim.keymap.set("n", "<leader>e", function()
	local MiniFiles = require("mini.files")
	local _ = MiniFiles.close() or MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
	vim.schedule(function()
		MiniFiles.reveal_cwd()
	end)
end)

-- Undotree
require("undotree").setup({})
vim.keymap.set("n", "<leader>u", function()
	require("undotree").toggle()
end)

-- Haunt (bookmarks/annotations)
local haunt = require("haunt.api")
local haunt_picker = require("haunt.picker")
local prefix = "<leader>h"
vim.keymap.set("n", prefix .. "a", function()
	haunt.annotate()
end, { desc = "Annotate" })
vim.keymap.set("n", prefix .. "t", function()
	haunt.toggle_annotation()
end, { desc = "Toggle annotation" })
vim.keymap.set("n", prefix .. "T", function()
	haunt.toggle_all_lines()
end, { desc = "Toggle all annotations" })
vim.keymap.set("n", prefix .. "d", function()
	haunt.delete()
end, { desc = "Delete bookmark" })
vim.keymap.set("n", prefix .. "C", function()
	haunt.clear_all()
end, { desc = "Delete all bookmarks" })
vim.keymap.set("n", prefix .. "p", function()
	haunt.prev()
end, { desc = "Previous bookmark" })
vim.keymap.set("n", prefix .. "n", function()
	haunt.next()
end, { desc = "Next bookmark" })
vim.keymap.set("n", prefix .. "l", function()
	haunt_picker.show()
end, { desc = "Show Picker" })
vim.keymap.set("n", prefix .. "q", function()
	haunt.to_quickfix()
end, { desc = "Show Picker" })
vim.keymap.set("n", prefix .. "Q", function()
	haunt.to_quickfix({ current_buffer = true })
end, { desc = "Show Picker" })
vim.keymap.set("n", prefix .. "y", function()
	haunt.yank_locations({ current_buffer = true })
end, { desc = "Show Picker" })
vim.keymap.set("n", prefix .. "Y", function()
	haunt.yank_locations()
end, { desc = "Show Picker" })

-- Snacks
local Snacks = require("snacks")

Snacks.setup({
	bigfile = { enabled = true },
	dashboard = {
		enabled = true,
		preset = {
			keys = {
				{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
				{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.picker.grep()" },
				{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
				{ icon = " ", key = "c", desc = "Config", action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })" },
				{ icon = "󰒲 ", key = "u", desc = "Update Plugins", action = ":lua vim.pack.update()" },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
		},
		sections = {
			{ section = "header" },
			{ section = "keys", gap = 1, padding = 1 },
			{ section = "recent_files", padding = 1 },
		},
	},
	indent = { enabled = true },
	input = { enabled = true },
	notifier = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	lazygit = {
		enabled = true,
		configure = true,
	},
	statuscolumn = {
		left = { "mark", "sign" },
		right = { "fold", "git" },
		folds = {
			open = false,
			git_hl = false,
		},
		git = {
			patterns = { "GitSign", "MiniDiffSign" },
		},
		refresh = 50,
		enabled = true,
	},
	words = { enabled = true },
	picker = { enabled = true },
	gh = { enabled = true },
})

vim.o.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get() .. '%#Normal# ']]

-- Snacks keymaps
vim.keymap.set("n", "<leader>lg", function()
	Snacks.lazygit.open()
end, { desc = "Snacks: Lazygit" })
vim.keymap.set("n", "<leader>t", function()
	Snacks.picker.smart()
end, { desc = "Snacks: Smart picker" })
vim.keymap.set("n", "<leader>sr", function()
	Snacks.picker.resume()
end, { desc = "Open previous search" })
vim.keymap.set("n", "<leader>/", function()
	Snacks.picker.grep()
end, { desc = "Snacks: Grep" })
vim.keymap.set("n", "<leader>D", function()
	Snacks.picker.diagnostics()
end, { desc = "Snacks: Diagnostics" })
vim.keymap.set("n", "<leader><space>", function()
	Snacks.picker.buffers({
		on_show = function()
			vim.cmd.stopinsert()
		end,
		finder = "buffers",
		format = "buffer",
		hidden = false,
		unloaded = true,
		current = true,
		sort_lastused = true,
		win = {
			input = {
				keys = {
					["d"] = "bufdelete",
				},
			},
			list = {
				keys = {
					["d"] = "bufdelete",
				},
			},
		},
	})
end, { desc = "Snacks: Buffers" })
vim.keymap.set("n", "<leader>ss", function()
	Snacks.picker.lsp_symbols()
end, { desc = "Snacks: LSP symbols" })
vim.keymap.set("n", "<leader>ff", function()
	Snacks.picker.files()
end, { desc = "Snacks: Files" })
vim.keymap.set("n", "<leader>sS", function()
	Snacks.picker.lsp_workspace_symbols()
end, { desc = "Snacks: Workspace symbols" })
vim.keymap.set("n", "gd", function()
	Snacks.picker.lsp_definitions({
		on_show = function()
			vim.cmd.stopinsert()
		end,
	})
end, { desc = "Snacks: LSP definitions" })
vim.keymap.set("n", "gi", function()
	Snacks.picker.lsp_implementations({
		on_show = function()
			vim.cmd.stopinsert()
		end,
	})
end, { desc = "Snacks: LSP implementations" })
vim.keymap.set("n", "gr", function()
	Snacks.picker.lsp_references({
		on_show = function()
			vim.cmd.stopinsert()
		end,
	})
end, { desc = "Snacks: LSP references" })
vim.keymap.set("n", "gy", function()
	Snacks.picker.lsp_type_definitions()
end, { desc = "Snacks: LSP type defs" })
vim.keymap.set("n", "<leader>.", function()
	vim.lsp.buf.code_action()
end, { desc = "LSP code action" })
vim.keymap.set("n", "<leader>ghi", function()
	Snacks.picker.gh_issue()
end, { desc = "GitHub Issues (open)" })
vim.keymap.set("n", "<leader>gI", function()
	Snacks.picker.gh_issue({ state = "all" })
end, { desc = "GitHub Issues (all)" })
vim.keymap.set("n", "<leader>gp", function()
	Snacks.picker.gh_pr()
end, { desc = "GitHub Pull Requests (open)" })
vim.keymap.set("n", "<leader>gP", function()
	Snacks.picker.gh_pr({ state = "all" })
end, { desc = "GitHub Pull Requests (all)" })
