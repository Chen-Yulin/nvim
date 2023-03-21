-- Load custom treesitter grammar for org filetype
require('orgmode').setup_ts_grammar()


require('orgmode').setup({
    org_agenda_files = {
                        '~/OneDrive/Common/org/*',
                        '~/OneDrive/Common/org/JI2023Innovation/*',
                        '~/OneDrive/Common/org/SR/*',
                        '~/OneDrive/Common/org/mod/*'
                        },
    org_default_notes_file = '~/OneDrive/Common/refile.org',
    org_todo_keywords = {'TODO','NEXT','|','DONE','DELEGATED'},
    org_todo_keyword_face = {
        WAITING = ':foreground blue :weight bold',
        DELEGATED = ':background #FFFFFF :slant italic :underline on',
        TODO = ':background #000000 :foreground red',
    },
    win_split_mode = 'auto'
})
