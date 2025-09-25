local ls = require("luasnip")
local lua_snip =
    require("luasnip.loaders.from_vscode").lazy_load({exclude = {}})

vim.lsp.config('lua_ls',
               {settings = {Lua = {diagnostics = {globals = {'vim'}}}}})
vim.lsp.config('grammarly', {
    cmd = {"grammarly-languageserver", "--stdio"},
    filetypes = {"markdown", "txt", "text", "tex", "md"}

})
vim.lsp.config('ltex', {
    settings = {
        language = "en-GB",
        enabled = {
            "bibtex", "context", "context.tex", "html", "latex", "markdown",
            "org", "restructuredtext", "rsweave", "vimwiki"
        },
        ltex = {
            enabled = {
                "bibtex", "gitcommit", "markdown", "org", "tex",
                "restructuredtext", "rsweave", "latex", "quarto", "rmd",
                "context", "html", "xhtml", "mail", "plaintext", "vimwiki"
            }
        }

    }
})
vim.lsp.config('ast_grep', {
    filetypes = {"c", "h", "cs", "js", "py", "ts", "html", "css", "lua", "Java"}

})
vim.lsp.config('pyright', {
    Settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
                extraPaths = {"/usr/lib64/python3.13/site-packages"}
            }
        }
    }
})
vim.lsp.config('marksman', {filetypes = {"markdown", "vimwiki"}})
-- vim.lsp.config("typos_lsp", {command = "typos-lsp" })
vim.lsp.config("typos_lsp", {cmd = {"typos-lsp", "--locale=en-gb"}})
vim.lsp.config("codebook", {
    cmd = {'codebook-lsp', 'serve'},
    filetypes = {
        'c', 'css', 'gitcommit', 'go', 'haskell', 'html', 'java', 'javascript',
        'javascriptreact', 'lua', 'markdown', 'php', 'python', 'ruby', 'rust',
        'toml', 'text', 'typescript', 'typescriptreact'
    },
    root_markers = {'.git', 'codebook.toml', '.codebook.toml'}
})
vim.lsp.enable("typos_lsp")
-- colour
vim.lsp.enable({name = "codebook", enable = false})
vim.lsp.enable({"mpls"})
vim.lsp.config('mpls', {
    cmd = {
        "mpls", "--dark-mode", "--enable-emoji", "--enable-footnotes",
        "--plantuml-server localhost:6969"
    },
    root_markers = {".marksman.toml", ".git"},
    filetypes = {"markdown", "makdown.mdx"},
    on_attach = function(client, bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, "MplsOpenPreview",
                                             function()
            local params = {command = "open-preview"}
            client.request("workspace/executeCommand", params, function(err, _)
                if err then
                    vim.notify("Error executing command: " .. err.message,
                               vim.log.levels.ERROR)
                else
                    vim.notify("Preview opened", vim.log.levels.INFO)
                end
            end)
        end, {desc = "Preview markdown with mpls"})
    end
})

-- =========================================================
-- Mason (Lsp installer, Dap installer, linter installer and formatter installer)
-- =========================================================
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    },
    registries = {
        "github:mason-org/mason-registry", "github:Crashdummyy/mason-registry"
    }
})
require("mason-lspconfig").setup({automatic_enable = {exclude = {"codebook"}}})
require("lsp.Roslyn")
-- require("lsp.roslywork")
-- =========================================================
-- CMP
-- =========================================================
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

local cmp_snippet = {
    expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- lua_snip.lsp_expand(args.body) -- For `luasnip` users.
    end
}

local cmp_mappings = {
    -- disables enter from triggering cmp
    ['<CR>'] = cmp.config.disable,
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ["<C-Space>"] = cmp.mapping.complete({
        config = {sources = {{name = 'luasnip'}}}
    }),
    ['<c-B>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
    ['<c-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
    ["<c-y>"] = cmp.mapping(cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true
    }, {"i", "c"})
}

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

local cmp_sources = {
    -- { name = 'cmdline', keyword_length = 5},
    {name = 'luasnip'}, -- For luasnip users.
    {
        name = 'nvim_lsp',
        -- ============================================================================
        -- NB gets rid of lsp snippets
        -- I.e the snippets that complete/expand but with the snippet trigger still there
        -- for example sout => soutSystem.Rest.of.snippet
        -- ============================================================================
        entry_filter = function(entry)
            return require("cmp").lsp.CompletionItemKind.Snippet ~=
                       entry:get_kind()
        end
    }, {name = 'path'}, {name = 'nvim_lua'},
    {name = 'buffer', keyword_length = 3}
}

cmp.setup.filetype({"sql"}, {
    sources = {{name = 'vim-dadbod-completion'}, {name = 'buffer'}}
})
cmp.setup({
    mapping = cmp_mappings,
    snippet = cmp_snippet,
    sources = cmp_sources,
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = entry.source.name
            return vim_item
        end
    }
})

--[[
-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({'/', '?'}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{name = 'buffer'}}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}}),
    matching = {disallow_symbol_nonprefix_matching = false}
})
    --]]
-- ===========================================================
-- Mappings
-- ==========================================================
local function toggle_lsp_server(name)
    local buf_clients = vim.lsp.get_clients({bufnr = 0})
    local found = false
    local message = ""
    for _, client in pairs(buf_clients) do
        if client.name == name and not client.is_stopped() then
            local namspace = vim.lsp.diagnostic.get_namespace(client.id, true)
            vim.lsp.enable({name = name, enable = false})
            --vim.diagnostic.hide(namspace)
            vim.diagnostic.enable(false, {ns_id = namspace})
           vim.diagnostic.reset()
           vim.lsp.stop_client(client.id)
            found = true
            -- print("Stopping " .. vim.inspect(client.name))
            message =
                message .. " Stopping " .. vim.inspect(client.name) .. ":" ..
                    client.id .. ":" .. namspace
        end
    end
    print(message)
    if not found then
        vim.lsp.enable(name)
        print("Starting " .. name)
        vim.cmd("LspStart " .. name)
    end
end
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufnr = args.buf
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id),
                              "must have valid client")
        local builtin = require "telescope.builtin"
        local opts = {buffer = bufnr, remap = false}
        local floating = {border = "single"}
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap
            .set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
        vim.keymap.set("n", "gI", function() vim.lsp.buf.implementation() end,
                       opts)
        vim.keymap.set("n", "<C-k>",
                       function() vim.lsp.buf.signature_help(floating) end, opts)
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "gR", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover(floating) end,
                       opts)
        vim.keymap
            .set("n", "ga", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "gA", function()
            -- vim.lsp.diagnostic.show_line_diagnostics();
            -- vim.lsp.util.show_line_diagnostics()
            vim.diagnostic.setqflist()
        end, opts)
        vim.keymap.set("n", "<C-n>", function()
            vim.diagnostic.goto_next()
        end, opts)
        vim.keymap.set("n", "<C-p>", function()
            vim.diagnostic.goto_prev()
        end, opts)
        vim.keymap.set("n", "<leader>vll", function() LspLocationList() end,
                       opts)
        -- Char 46 is '.'
        vim.keymap.set("n", "<Char-46>",
                       function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<F7>", function() vim.lsp.buf.format() end, opts)

        vim.keymap.set("n", "<leader>mt",
        -- function() toggle_lsp_server_diagnostics("codebook") end, opts)
                       function() toggle_lsp_server("codebook") end, opts)

    end

})
local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('*', {capabilities = capabilities, root_marks = {'.git'}})

vim.diagnostic.config({virtual_text = true})

ls.filetype_extend("csharp", {"csharpdoc"})
ls.filetype_extend("cs", {"csharpdoc"})
vim.keymap.set("i", "<C-h>", function() ls.jump(-1) end)
vim.keymap.set("i", "<C-l>", function() ls.jump(1) end)
vim.keymap.set("s", "<C-l>", function() ls.jump(1) end)
vim.keymap.set("s", "<C-h>", function() ls.jump(-1) end)

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = {'*.md', '*.tex'},
    group = group,
    command = 'setlocal wrap'
})

require('mason-nvim-dap').setup({
    ensure_installed = {'stylua', 'jq'},
    handlers = {} -- sets up dap in the predefined manner
})
vim.keymap.set("i", "<C-g>", function() ls.expand() end)

vim.diagnostic.config({
    virtual_text = {
        source = "always",
        prefix = function(args)
            local diagnostic = args.severity
            local enums = {
                [vim.diagnostic.severity.ERROR] = '',
                [vim.diagnostic.severity.WARN] = '',
                [vim.diagnostic.severity.INFO] = '󰋼',
                [vim.diagnostic.severity.HINT] = '󰌵'
            }
            return enums[diagnostic]
        end
    },

    --[[
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] ='E',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '󰋼',
            [vim.diagnostic.severity.HINT] = '󰌵'
        }
    },
    --]]
    update_in_insert = false,
    underline = true,
    severity_sort = true
})
vim.lsp.enable({name = "codebook", enable = false})
