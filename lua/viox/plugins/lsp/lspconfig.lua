return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "Hoffs/omnisharp-extended-lsp.nvim",
        {
            "ray-x/lsp_signature.nvim", -- for function argument highlighting
            -- i dont think i need this because all of the dependencies are lazy loaded
            -- event = "VeryLazy",
            opts = {
                hint_enable = true,
                floating_window = false,
                hint_inline = function() -- can be changed for nvim 0.10
                    return false
                end,
                handler_opts = {
                    border = "rounded",
                },
            },
            config = function(_, opts)
                require("lsp_signature").setup(opts)
            end,
        },
    },

    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")


        local on_attach = function(client, bufnr)
            -- function for easier remapping
            local nmap = function(keys, func, desc)
                if desc then
                    desc = "LSP: " .. desc
                end

                vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
            end

            local telBuit = require("telescope.builtin")

            nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
            nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

            -- if omnisharp is the lsp we use
            -- then we add some options with omnisharp_extended
            -- else we use regular telescope configuration

            if (client.name == "omnisharp") then
                -- vim.api.nvim_set_keymap('n', 'gr',
                --     '<cmd>lua require("omnisharp_extended").telescope_lsp_references()<cr>',
                --     { noremap = true, silent = true })
                vim.api.nvim_set_keymap('n', 'gn',
                    '<cmd>lua require("omnisharp_extended").telescope_lsp_definition()<cr>',
                    { noremap = true, silent = true })
                -- vim.api.nvim_set_keymap('n', '<leader>D',
                --     '<cmd>lua require("omnisharp_extended").telescope_lsp_type_definition()<cr>',
                --     { noremap = true, silent = true })
                -- vim.api.nvim_set_keymap('n', 'gI',
                --     '<cmd>lua require("omnisharp_extended").telescope_lsp_implementation()<cr>',
                --     { noremap = true, silent = true })
            end

            nmap("gd", telBuit.lsp_definitions, "[G]oto [D]efinition")
            nmap("gr", telBuit.lsp_references, "[G]oto [R]eferences")
            nmap("gI", telBuit.lsp_implementations, "[G]oto [I]mplementation")

            nmap("<leader>D", telBuit.lsp_type_definitions, "Type [D]efinition")
            nmap("<leader>ds", telBuit.lsp_document_symbols, "[D]ocument [S]ymbols")
            nmap("<leader>ws", telBuit.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

            -- different hover documentation
            nmap("K", vim.lsp.buf.hover, "Hover Documentation")
            nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

            -- Lesser used LSP functionality
            nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
            nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
            nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
            nmap("<leader>wl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, "[W]orkspace [L]ist Folders")
            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
                vim.lsp.buf.format()
            end, { desc = "Format current buffer with LSP" })
        end

        -- Add additional capabilities supported by nvim-cmp
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- configure html server
        lspconfig["html"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure typescript server
        lspconfig["ts_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure css server
        lspconfig["cssls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- somesass_ls
        lspconfig["somesass_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig["emmet_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = {
                --[[ "css", ]]
                "eruby",
                "html",
                "javascript",
                "javascriptreact",
                -- "less",
                -- "sass",
                -- "scss",
                "svelte",
                "pug",
                "typescriptreact",
                "vue",
            },
        })

        lspconfig["tailwindcss"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- search tags [ java, javalsp, jdtls ]
        -- we use (nvim-jdtls)

        lspconfig["omnisharp"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = {
                "/home/viox/.local/share/nvim/mason/bin/omnisharp",
                "--languageserver",
                "--hostPID", tostring(vim.fn.getpid()),
                "--loglevel", "trace"
            },
        })

        lspconfig["lemminx"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig["bashls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- python lsp
        lspconfig["basedpyright"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure clangd  server
        lspconfig["clangd"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        })
    end,
}
