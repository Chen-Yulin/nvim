local neocodeium = require("neocodeium")

neocodeium.setup({
	manual = true, -- recommended to not conflict with nvim-cmp
	filetypes = {
		TelescopePrompt = false,
		["dap-repl"] = false,
	},
})

-- create an autocommand which closes cmp when ai completions are displayed
vim.api.nvim_create_autocmd("User", {
	pattern = "NeoCodeiumCompletionDisplayed",
	callback = function()
		require("cmp").abort()
	end,
})
