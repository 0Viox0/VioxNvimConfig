return {
    "rebelot/kanagawa.nvim",
    opts = {
        colors = {
            theme = {
                all = {
                    ui = {
                        bg_gutter = "none",
                    },
                },
            },
        },

        overrides = function(colors)
            local theme = colors.theme
            return {
                -- dark autocompletion menu
                Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
                PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                PmenuSbar = { bg = theme.ui.bg_m1 },
                PmenuThumb = { bg = theme.ui.bg_p2 },
            }
        end,
    },
    init = function()
        require("kanagawa").load("dragon")
    end,
}
