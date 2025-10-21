local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"

local plugins = {}

for _, file in ipairs(vim.fn.readdir(plugin_dir, [[v:val =~ '\.lua$']])) do
	if file ~= "init.lua" then
		local name = file:gsub("%.lua$", "")
		local ok, plugin = pcall(require, "plugins." .. name)
		if ok then
			table.insert(plugins, plugin)
		else
			vim.notify("Error loading plugin: " .. name, vim.log.levels.ERROR)
		end
	end
end

return plugins
