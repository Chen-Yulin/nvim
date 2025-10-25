require("codecompanion").setup({
	strategies = {
		chat = {
			adapter = "copilot",
            model = "claude-sonnet-4"
		},
		inline = {
			adapter = "copilot",
            model = "claude-sonnet-4"
		},
	},
})
