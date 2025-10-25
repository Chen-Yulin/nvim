require("codecompanion").setup({
	strategies = {
		chat = {
			adapter = {
				name = "copilot",
				model = "claude-sonnet-4",
			},
		},
		inline = {
			adapter = {
				name = "copilot",
				model = "claude-sonnet-4",
			},
		},
	},
})
