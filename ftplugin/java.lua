local jdtls_dir = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local config_dir = jdtls_dir .. "/config_linux"
local plugins_dir = jdtls_dir .. "/plugins/"
local path_to_jar = plugins_dir .. "org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar"
local path_to_lombok = jdtls_dir .. "/lombok.jar"

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
    return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name
-- os.execute("mkdir " .. workspace_dir)

-- Main Config
local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {
        -- "/usr/lib/jvm/jdk-21-oracle-x64/",
        -- "/usr/bin/java",
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-javaagent:" .. path_to_lombok,
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",

        "-jar",
        path_to_jar,
        "-configuration",
        config_dir,
        "-data",
        workspace_dir,
    },

    root_dir = root_dir,

    settings = {
        java = {
            home = "/usr/lib/jvm/jdk-21-oracle-x64",
            -- home = "/usr/bin/java",
            -- home = "java",
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
                runtimes = {
                    {
                        name = "JavaSE-21",
                        path = "/usr/lib/jvm/jdk-21-oracle-x64",
                        -- path = "/usr/bin/java",
                    },
                },
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            format = {
                enabled = true,
                settings = {
                    url = vim.fn.stdpath("config") .. "/lang-servers/intellij-java-google-style.xml",
                    profile = "GoogleStyle",
                },
            },
        },

        signatureHelp = { enabled = true },

        completion = {
            favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
            },
            importOrder = {
                "java",
                "javax",
                "com",
                "org",
            },
        },

        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
        },

        flags = {
            allow_incremental_sync = true,
        },
        init_options = {
            bundles = {},
        },
    },
}

-- different keymaps
config["on_attach"] = function(client, bufnr)
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

    --for jdtls
    local spring_boot_run = "mvn spring-boot:run -Dspring-boot.run.profiles=local"
    local command = ':lua require("toggleterm").exec("' .. spring_boot_run .. '")<CR>'
    vim.keymap.set("n", "<leader>sr", command)
    vim.keymap.set("n", "<leader>oi", ':lua require("jdtls").organise_imports()<CR>')
    vim.keymap.set("n", "<leader>jc", ':lua require("jdtls").compile("incremental")')
    require("lsp_signature").on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        floating_window_above_cur_line = false,
        padding = "",
        handler_opts = {
            border = "rounded",
        },
    }, bufnr)
end

require("jdtls").start_or_attach(config)
