local status, gitconflict = pcall(require, "git-conflict")
if not status then
	vim.notify("没有找到 git-conflict")
	return
end

gitconflict.setup({
	default_mappings = true, -- disable buffer local mapping created by this plugin
	default_commands = true, -- disable commands created by this plugin
	disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
	highlights = { -- They must have background color, otherwise the default color will be used
		incoming = "DiffText",
		current = "DiffAdd",
	},
})
