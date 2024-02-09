local status, ibl = pcall(require, "ibl")
if not status then
	vim.notify("没有找到 indent_blankline")
	return
end

ibl.setup({
	indent = {
		char = "▏",
	},
	scope = {
		enabled = true,
		show_start = true,
		show_end = true,
	},
	--[[
	-- 空行占位
	space_char_blankline = " ",
	-- 用 treesitter 判断上下文
	show_current_context = true,
	show_current_context_start = true,
	context_patterns = {
		"class",
		"function",
		"method",
		"element",
		"^if",
		"^while",
		"^for",
		"^object",
		"^table",
		"block",
		"arguments",
	},
	-- :echo &filetype
	filetype_exclude = {
		"dashboard",
		"packer",
		"terminal",
		"help",
		"log",
		"markdown",
		"TelescopePrompt",
		"lsp-installer",
		"lspinfo",
		"toggleterm",
	},
	-- 竖线样式
	-- char = '¦'
	-- char = '┆'
	-- char = '│'
	-- char = "⎸",
	char = "▏",--]]
})
