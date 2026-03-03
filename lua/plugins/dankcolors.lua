return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#0e1416',
				base01 = '#0e1416',
				base02 = '#868d8d',
				base03 = '#868d8d',
				base04 = '#2b2e2e',
				base05 = '#f0f9fa',
				base06 = '#f0f9fa',
				base07 = '#f0f9fa',
				base08 = '#d62050',
				base09 = '#d62050',
				base0A = '#00adc0',
				base0B = '#00b710',
				base0C = '#6cced9',
				base0D = '#00adc0',
				base0E = '#adf7ff',
				base0F = '#adf7ff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#868d8d',
				fg = '#f0f9fa',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#00adc0',
				fg = '#0e1416',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#868d8d' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#6cced9', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#adf7ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#00adc0',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#00adc0',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#6cced9',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#00b710',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#2b2e2e' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#2b2e2e' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#868d8d',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
