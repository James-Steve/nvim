local lsp = require("lsp-zero")

local ls = require("luasnip")
local lua_snip = require("luasnip.loaders.from_vscode").lazy_load({
    exclude = {},
})
--From Desktop
lsp.preset("recommended")
lsp.set_preferences({ manage_luasnip = false })
--end from Desktop

lsp.preset("recommended")
lsp.set_preferences({ manage_luasnip = false })

--[[
lsp.ensure_installed({

    --'tsserver',
    --'rust_analyzer',
    --    'sumneko_lua',
    --'texlab',
    --'ltex',
    "rust_analyzer",
    "lua_ls",
    "texlab",
    "bashls",
    "grammarly",
    "omnisharp",
    "omnisharp_mono",
    "csharp_ls",
})
--]]
-- Fix Undefined global 'vim'
--======================================================
--Configuring Custom Servers
--======================================================
lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

lsp.configure('grammarly', {
    cmd = { "grammarly-languageserver", "--stdio" },
    filetypes = { "markdown", "txt", "text", "tex" }

})
lsp.configure('ast_grep', {
    filetypes = { "c", "h", "cs", "js", "py", "ts", "html", "css", "lua", "Java" }

})
--=========================================================
--Mason (Lsp installer, Dap installer, linter installer and formatter installer)
--=========================================================
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require("mason-lspconfig").setup {
    --ensure_installed = { "rust_analyzer", "lua_ls", "texlab", "bashls", "grammarly", "omnisharp", "omnisharp_mono", "csharp_ls", "netcoredbg" }                --"csharpier", "clang-format"}
}
--vim.cmd "MasonInstall  rust_analyzer lua_ls texlab bashls grammarly omnisharp omnisharp_mono csharp_ls netcoredbg"
--=========================================================
--CMP
--=========================================================
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

local cmp_snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        lua_snip.lsp_expand(args.body)           -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
}

local cmp_mappings = lsp.defaults.cmp_mappings({
    --disables enter from triggering cmp
    ['<CR>'] = cmp.config.disable,
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ["<C-Space>"] = cmp.mapping.complete({
        config = {
            sources = {
                { name = 'luasnip' } }
        }
    }),
    ['<c-B>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<c-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ["<c-y>"] = cmp.mapping(
        cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        },
        { "i", "c" }
    ),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

local cmp_sources = {
    --{ name = 'cmdline', keyword_length = 5},
    { name = 'luasnip' }, -- For luasnip users.
    {
        name = 'nvim_lsp',
        --============================================================================
        --NB gets rid of lsp snippets
        --I.e the snippets that complete/expand but with the snippet trigger still there
        --for example sout => soutSystem.Rest.of.snippet
        --============================================================================
        entry_filter = function(entry)
            return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
        end
    },
    { name = 'path' },
    { name = 'nvim_lua' },
    { name = 'buffer',  keyword_length = 3 },
}

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
    snippet = cmp_snippet,
    sources = cmp_sources,
})



lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})
--===========================================================
--Mappings
--==========================================================
lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }


    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "gI", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "<C-k>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "gR", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "ga", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "gA",
        function()
            vim.lsp.diagnostic.show_line_diagnostics();
            vim.lsp.util.show_line_diagnostics()
        end, opts)
    vim.keymap.set("n", "<C-n>", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "<C-p>", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vll", function() LspLocationList() end, opts)
    --Char 46 is '.'
    vim.keymap.set("n", "<Char-46>", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<F7>", function() vim.lsp.buf.format() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

ls.filetype_extend("csharp", {"csharpdoc"})
ls.filetype_extend("cs", {"csharpdoc"})
vim.keymap.set("i", "<C-h>", function() ls.jump(-1) end)
vim.keymap.set("i", "<C-l>", function() ls.jump(1) end)
vim.keymap.set("s", "<C-l>", function() ls.jump(1) end)
vim.keymap.set("s", "<C-h>", function() ls.jump(-1) end)

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = { '*.md', '*.tex' },
    group = group,
    command = 'setlocal wrap'
})


require('mason-nvim-dap').setup({
    ensure_installed = { 'stylua', 'jq' },
    handlers = {
        --[[
        coreclr = function(source_name)
            local dap = require("dap")
            dap.adapters.coreclr = {
                type = 'executable',
                command = 'netcoredbg',
                args = { '--interpreter=cli' }
            }

            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "launch - netcoredbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
                    end,
                },
            }
        end,
        --]]
    }, -- sets up dap in the predefined manner
})
vim.keymap.set("i", "<C-g>", function() ls.expand() end)
