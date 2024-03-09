return {
    "ThePrimeagen/harpoon",
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        vim.keymap.set("n", "<leader>a", mark.add_file)
        vim.keymap.set("n", "<leader>m", ui.toggle_quick_menu)

        vim.keymap.set("n", "<a-q>", function()
            ui.nav_file(1)
        end)
        vim.keymap.set("n", "<a-w>", function()
            ui.nav_file(2)
        end)
        vim.keymap.set("n", "<a-e>", function()
            ui.nav_file(3)
        end)
        vim.keymap.set("n", "<a-r>", function()
            ui.nav_file(4)
        end)
        vim.keymap.set("n", "<a-t>", function()
            ui.nav_file(5)
        end)

        vim.cmd("highlight! HarpoonInactive guibg=NONE guifg=#63698c")
        vim.cmd("highlight! HarpoonActive guibg=NONE guifg=white")
        vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
        vim.cmd("highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7")
        vim.cmd("highlight! TabLineFill guibg=NONE guifg=white")
    end,
}
