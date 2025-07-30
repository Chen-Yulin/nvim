require("codecompanion").setup({
	strategies = {
		chat = {
			adapter = {
				name = "copilot",
				model = "claude-sonnet-4-20250514",
			},
		},
		inline = {
			adapter = {
				name = "copilot",
				model = "claude-sonnet-4-20250514",
			},
		},
	},
})
