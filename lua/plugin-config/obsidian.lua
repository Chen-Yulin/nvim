require("obsidian").setup({
    dir = "~/OneDrive/Common/obsidian/CYL Planet/",
    templates = {
        subdir="template"
    },
    completion = {
        nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
    }
})
