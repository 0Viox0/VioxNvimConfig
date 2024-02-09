return {
    -- i couldn't figure out how to synchronize it with harpoon
    -- so that when i delete the buffer in harpoon it also dissapears in tabline
    --
    -- "kdheepak/tabline.nvim",
    -- config = function()
    --     require("tabline").setup({
    --         enable = true,
    --         options = {},
    --         show_tabs_always = false,
    --     })
    --
    --     vim.cmd("highlight! HarpoonInactive guibg=NONE guifg=#63698c")
    --     vim.cmd("highlight! HarpoonActive guibg=NONE guifg=white")
    --     vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
    --     vim.cmd("highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7")
    --     vim.cmd("highlight! TabLineFill guibg=NONE guifg=white")
    -- end,
    -- dependencies = { "hoob3rt/lualine.nvim", "kyazdani42/nvim-web-devicons" },
}
