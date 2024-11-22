vim.api.nvim_create_user_command("InitCFormat", function(input)
	os.execute("cp ~/.config/nvim/formatter_conf/.clang-format ./")
	-- implementation here
end, { nargs = "*" })
