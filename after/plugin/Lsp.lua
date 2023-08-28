local lsp = require("lsp-zero")
--local lua_snip = require("luasnip")
local lua_snip = require("luasnip.loaders.from_vscode").load {
    exclude = { "latex" },
}
lsp.preset("recommended")
lsp.set_preferences({manage_luasnip = false})

--[[
lsp.ensure_installed({
    'tsserver',
    'rust_analyzer',
    'sumneko_lua',
})
--]]
-- Fix Undefined global 'vim'
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
   filetypes = { "markdown", "txt", "text" }

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
    ensure_installed = { "rust_analyzer", "lua_ls", "texlab", "bashls", "grammarly"}
}
--=========================================================
--CMP
--=========================================================
local cmp = require('cmp')
--[[
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    sources = cmp.config.sources({
        --    { name = 'cmdline', keyword_length = 5},
        { name = 'nvim_lua'},
        { name = 'nvim_lsp'},
        { name = 'vsnip'}, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.

        --   { name = 'path', keyword_length = 1},
        { name = 'buffer', keyword_length = 5 },
    })

})
--]]
local cmp_select = { behavior = cmp.SelectBehavior.Select }

local cmp_snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        lua_snip.lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
}

local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ["<C-Space>"] = cmp.mapping.complete({
        config = {
            sources = {
                { name = 'luasnip' } } } }),
    ['<c-b>'] = cmp.mapping(cmp.mapping.scroll_docs( -4), { 'i', 'c' }),
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
    --    { name = 'cmdline', keyword_length = 5},
    { name = 'luasnip' }, -- For luasnip users.
    { name = 'nvim_lsp',
    --============================================================================
    --NB gets rid of lsp snippets
    --I.e the snippets that complete/expand but with the snippet trigger still there 
    --for example sout => soutSystem.Rest.of.snippet
    --============================================================================
    entry_filter = function(entry)
                return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
            end },
    { name = 'path' },
    { name = 'nvim_lua' },
    { name = 'buffer',  keyword_length = 3 },
    --{ name = 'l

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

vim.keymap.set("i", "<C-l>", function() lua_snip.jump(1) end)
vim.keymap.set("i", "<C-h>", function() lua_snip.jump( -1) end)
vim.keymap.set("s", "<C-l>", function() lua_snip.jump(1) end)
vim.keymap.set("s", "<C-h>", function() lua_snip.jump( -1) end)
