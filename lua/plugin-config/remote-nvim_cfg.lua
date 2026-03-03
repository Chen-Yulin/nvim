local status, remotenvim = pcall(require, "remote-nvim")
if not status then
	vim.notify("没有找到 remote-nvim")
	return
end
remotenvim.setup({
	remote = {
		copy_dirs = {
			config = {
				compression = {
					enabled = true,
					additional_opts = { "--exclude-vcs" },
				},
			},
		},
	},
})
