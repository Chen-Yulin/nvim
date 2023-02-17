-- Load custom treesitter grammar for org filetype
require('orgmode').setup_ts_grammar()

-- Treesitter configuration
require('nvim-treesitter.configs').setup {
    -- If TS highlights are not enabled at all, or disabled via `disable` prop,
    -- highlighting will fallback to default Vim syntax highlighting
    highlight = {
    enable = true,
    -- Required for spellcheck, some LaTex highlights and
    -- code block highlights that do not have ts grammar
    additional_vim_regex_highlighting = {'org'},
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

require('orgmode').setup({
    org_agenda_files = {'~/OneDrive/Common/org/*'},
    org_default_notes_file = '~/OneDrive/Common/refile.org',
    org_todo_keywords = {'TODO','NEXT','|','DONE','DELEGATED'},
    org_todo_keyword_face = {
        WAITING = ':foreground blue :weight bold',
        DELEGATED = ':background #FFFFFF :slant italic :underline on',
        TODO = ':background #000000 :foreground red',
    },
    win_split_mode = 'auto'
})
