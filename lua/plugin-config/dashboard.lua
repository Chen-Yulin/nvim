local status, db = pcall(require, "dashboard")
if not status then
	vim.notify("没有找到 dashboard")
	return
end

db.custom_footer = {
	"",
	"",
	"https://github.com/Chen-Yulin",
}

db.custom_center = {
	{
		icon = "  ",
		desc = "Projects                            ",
		action = "Telescope projects",
	},
	{
		icon = "  ",
		desc = "Edit Projects                       ",
		action = "edit ~/.local/share/nvim/project_nvim/project_history",
	},
	{
		icon = "  ",
		desc = "Recently files                      ",
		action = "Telescope oldfiles",
	},
	{
		icon = "  ",
		desc = "Find file                           ",
		action = "Telescope find_files",
	},
	{
		icon = "  ",
		desc = "Edit keybindings                    ",
		action = "edit ~/.config/nvim/lua/keybindings.lua",
	},
	-- {
	--   icon = "  ",
	--   desc = "Edit .bashrc                        ",
	--   action = "edit ~/.bashrc",
	-- },
	-- {
	--   icon = "  ",
	--   desc = "Change colorscheme                  ",
	--   action = "ChangeColorScheme",
	-- },
	{
		icon = "  ",
		desc = "Edit init.lua                       ",
		action = "edit ~/.config/nvim/init.lua",
	},
	-- {
	--   icon = "  ",
	--   desc = "Find text                           ",
	--   action = "Telescopecope live_grep",
	-- },
}
local MJ0 = {
	[[⠀⠀⠀⠀⠀⠀⠀⡄⠀⣶⠀⢠       ]],
	[[⠀⠀⠀⠀⠀⢻⡀⣿⠀⣿⠀⣿⢀⡏     ]],
	[[⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿      ]],
	[[⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿      ]],
	[[⠀⠀⠀⠀⠀⠀⢬⣭⣭⣭⣭⣭⡥      ]],
	[[⠀⣀⣀⣀⣀⣀⡀⠀⢸⣿⣿⠀⠀⣀⣀⣀⣀⣀ ]],
	[[⠀⠀⠀⣿⣿⣆⠀⠀⢸⣿⣿⠀⠀⢀⣿⣿⣧  ]],
	[[⠀⠀⢠⣿⢿⣿⣆⠀⢸⣿⣿⠀⠀⣿⠉⣿⣿  ]],
	[[⠀⠀⢸⡟⠀⣿⣿⣆⢸⣿⣿⠀⣾⠃⠀⣿⣿  ]],
	[[⠀⠀⣿⡇⠀⠈⣿⣿⣾⣿⣿⣼⠏⠀⠀⣿⣿  ]],
	[[⠀⠀⣿⡇⠀⠀⠈⣿⣿⣿⣿⡟⠀⠀⠀⣿⣿  ]],
	[[⠀⠀⣿⡇⠀⠀⠀⠘⣿⣿⣿⠀⠀⠀⠀⣿⣿⡆ ]],
	[[⣀⣠⣿⣇⣀⠀⠀⠀⢸⣿⣿⠀⠀⣀⣀⣿⣿⣧⣀]],
	[[⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⠃        ]],
	[[⠀⠀⠀⠀⠀⠀⠀⢠⣿⠋         ]],
	[[⠀⠀⠀⠀⠀⠀⢠⠛           ]],
}

local MJ1 = {
	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⣶⣿⣿⣿⣿⣿⣿⣷⣁              ]],
	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄           ]],
	[[⠀⠀⠀⠀⠀⠀⠀⠀⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣀         ]],
	[[⠀⠀⠀⠀⠀⠀⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣅        ]],
	[[⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄       ]],
	[[⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⠿⠁⠀⠀⠉⠀⣿⡟⢨⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⠒      ]],
	[[⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⠒      ]],
	[[⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣶⣄⠀⠀⠀⣿⣤⣶⠶⠶⣤⠊⢿⣿⣿⣿⣿⣿⣄      ]],
	[[⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⠟⠿⢿⠀⠀⠘⣿⡟⣿⡞⣿⠽⠀⢸⣿⣿⣿⣿⣿⠋      ]],
	[[⠀⠀⠀⠀⠀⠀⢤⣿⣿⠀⠀⠀⠀⠀⡠⠀⠀⠀⠀⠀⠈⠉⠀⠀⠀⣸⣿⠆⣱⣿⠻       ]],
	[[⠀⠀⠀⠀⠀⠆⢘⣿⣿⣧⡀⠀⠀⣤⣾⣦⣤⡀⠉⠀⠀⠀⠀⠀⠀⣿⠀⢠⣿⣿⠈       ]],
	[[⠀⠀⠀⠀⠀⠀⢴⡿⢿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣥⣴⣿⣿⣿⡎       ]],
	[[⠀⠀⠀⠐⣶⣶⣿⣿⣿⣿⣿⡍⢻⣿⠛⠛⠛⠛⠒⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⠇       ]],
	[[⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣷⠀⠈⠉⠉⠁⠀⠀⠀⠀⠀⢀⡴⠰⣿⣿⣿⣿⣶⣶⣶⣶⣷⣶⣀  ]],
	[[⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣶⣤⣶⣤⣤⣤⣶⡿⠛⠁⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦ ]],
	[[⠀⠀⠀⣀⣠⣀⣀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠁⠀⠀⠀⠀⠀⠀⣿⣿⠿⠛⢿⣿⣿⣿⣿⠿⠿⣿⣧]],
	[[⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⣀⣼⣿⣿⣿⣿⣦⡀  ]],
	[[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠙⠀⠙⠿⢿⡟⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿]],
	[[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
	[[⣿⣿⣿⣿⢟⢭⢿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣻⢿⣿⣿⣿⣿⠟⠉ ]],
}

db.custom_header = MJ0

db.setup({
	theme = "hyper",
	config = {
		header = MJ0,
		week_header = {
			enable = false,
		},

		shortcut = {
			--        { desc = ' Update', group = '@property', action = 'Lazy update', key = 'u' },
			{
				desc = " Files",
				group = "Label",
				action = "Telescope find_files",
				key = "f",
			},
			--        {
			--          desc = ' Apps',
			--          group = 'DiagnosticHint',
			--          action = 'Telescope app',
			--          key = 'a',
			--        },
			--        {
			--          desc = ' dotfiles',
			--          group = 'Number',
			--          action = 'Telescope dotfiles',
			--          key = 'd',
			--        },
		},
		footer = {
			"",
			"",
			"https://github.com/Chen-Yulin",
		},
	},
})
