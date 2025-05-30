-- 如果找不到lualine 组件，就不继续执行
local status, lualine = pcall(require, "lualine")
if not status then
	vim.notify("没有找到 lualine")
	return
end

lualine.setup({
	options = {
		theme = "sonokai",
		component_separators = { left = "|", right = "|" },
		-- https://github.com/ryanoasis/powerline-extra-symbols
		section_separators = { left = "", right = "" },
	},
	extensions = { "nvim-tree", "toggleterm" },
	sections = {
		lualine_c = {
			{
				"tabs",
				tab_max_length = 40, -- Maximum width of each tab. The content will be shorten dynamically (example: apple/orange -> a/orange)
				max_length = vim.o.columns / 3, -- Maximum width of tabs component.
				-- Note:
				-- It can also be a function that returns
				-- the value of `max_length` dynamically.
				mode = 2, -- 0: Shows tab_nr
				-- 1: Shows tab_name
				-- 2: Shows tab_nr + tab_name

				path = 3, -- 0: just shows the filename
				-- 1: shows the relative path and shorten $HOME to ~
				-- 2: shows the full path
				-- 3: shows the full path and shorten $HOME to ~
				use_mode_colors = false,

				buffers_color = {
					-- Same values as the general color option can be used here.
					active = "lualine_{section}_normal", -- Color for active buffer.
					inactive = "lualine_{section}_inactive", -- Color for inactive buffer.
				},

				show_modified_status = true, -- Shows a symbol next to the tab name if the file has been modified.
				symbols = {
					modified = "[+]", -- Text to show when the file is modified.
				},

				fmt = function(name, context)
					-- Show + if buffer is modified in tab
					local buflist = vim.fn.tabpagebuflist(context.tabnr)
					local winnr = vim.fn.tabpagewinnr(context.tabnr)
					local bufnr = buflist[winnr]
					local mod = vim.fn.getbufvar(bufnr, "&mod")

					return name .. (mod == 1 and " +" or "")
				end,
			},
			{
				"lsp_progress",
				spinner_symbols = { " ", " ", " ", " ", " ", " " },
			},
		},
		lualine_x = {
			{
				"searchcount",
				maxcount = 999,
				timeout = 500,
			},
			"filesize",
			{
				"fileformat",
				symbols = {
					unix = "", -- e712
					dos = "", -- e70f
					mac = "", -- e711
				},
				-- symbols = {
				-- 	unix = "LF",
				-- 	dos = "CRLF",
				-- 	mac = "CR",
				-- },
			},
			"encoding",
			"filetype",
		},
	},
})
