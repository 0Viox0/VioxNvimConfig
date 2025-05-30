vim.o.autoindent = true         -- will use indent of the previous line when going to the new one
vim.o.expandtab = true          -- now we can configure the number of spaces used for <tab>
vim.o.breakindent = true        -- for indenting wrapped arguments in stuff
vim.o.tabstop = 4               -- number of spaces used for <tab>
vim.o.shiftwidth = 4            -- number of spaces used for autoindent

vim.o.hlsearch = false          -- highlight on search

vim.o.clipboard = "unnamedplus" -- sync clipboards between os and nvim

vim.o.number = true             -- for displaying the current line number instead of 0
vim.o.relativenumber = true     -- for relative numbers

vim.o.undofile = true           -- saves undo file to undo when opening file again

vim.o.ignorecase = true         -- search with insensitive searching
vim.o.smartcase = true          -- unless \C or capital in search

vim.wo.signcolumn = "yes"       -- add sign collumn to the left by default
-- for avoiding flickering and inconsistent pages

vim.o.updatetime = 250 -- saving to swap file after not typing for 250ms in case of crashes
vim.o.timeoutlen = 300 -- the value of timeout length

-- autocomplete settings
-- 'menuone' - show options even if there is one match
-- 'noselect' prevents the automatic selection of the first completion item in the menu
vim.o.completeopt = "menuone,noselect"

vim.o.termguicolors = true -- enables the use of true color in the terminal (for better colors)

-- setting block-only cursor
vim.cmd("set guicursor=a:block-Cursor")

-- highlight yanked text for 200ms using the "Visual" highlight group
vim.cmd([[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
augroup END
]])

-- setting up vim diagnostic config
vim.diagnostic.config({
    virtual_text = {
        spacing = 2,
        prefix = "●",
    },
    underline = false,
    update_in_insert = true,
    severity_sort = true,
})
