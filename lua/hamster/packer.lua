vim.cmd.packadd("packer.nvim")

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    -- telescope
    use({
        "nvim-telescope/telescope.nvim", -- tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = {
            {"nvim-lua/plenary.nvim"},
            {"nvim-telescope/telescope-file-browser.nvim"},
            {"kiyoon/telescope-insert-path.nvim"}
        }
    })

    -- treesitter
    use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})
    use("nvim-treesitter/playground")
    use("nvim-treesitter/nvim-treesitter-context")

    -- undotree
    use("mbbill/undotree")
    -- HARPOON!!
    use("theprimeagen/harpoon")
    -- Snippets
    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "v1.x",
        requires = {
            -- LSP Support
            {"neovim/nvim-lspconfig"}, -- Required
            {"williamboman/mason.nvim"}, -- Optional
            {"williamboman/mason-lspconfig.nvim"}, -- Optional
            {"mfussenegger/nvim-dap"}, {"jay-babu/mason-nvim-dap.nvim"},
            {"rcarriga/nvim-dap-ui"}, -- Autocompletion
            {"hrsh7th/nvim-cmp"}, -- Required
            {"hrsh7th/cmp-nvim-lsp"}, -- Required
            {"hrsh7th/cmp-buffer"}, -- Optional
            {"hrsh7th/cmp-path"}, -- Optional
            {"saadparwaiz1/cmp_luasnip"}, -- Optional
            {"hrsh7th/cmp-nvim-lua"}, -- Optional
            -- Snippets
            {"J0rgeSerran0/vscode-csharp-snippets"}
            -- {'luasnip-expand-or-jump'},

            --[[
            {'hrsh7th/vim-vsnip'},
            {'hrsh7th/vim-vsnip-integ'},
            --actual snippet
            {'rafamadriz/friendly-snippets'},
            {'J0rgeSerran0/vscode-csharp-snippets'},
--]]
        }
    })
    use("rafamadriz/friendly-snippets")
    use({"L3MON4D3/LuaSnip", dependencies = {"rafamadriz/friendly-snippets"}})
    use("mfussenegger/nvim-jdtls")
    -- ====================================================================
    -- NEED to integrate these
    -- ==================================================================

    use("luisiacc/gruvbox-baby", {"branch : main"})

    -- autobrackets, curlybraces, quatation marks,etc
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
            require("nvim-autopairs").clear_rules()
        end
    })

    -- indentation marker
    use({
        "lukas-reineke/indent-blankline.nvim",
        tag = "v2.20.8",
        config = function()
            require("indent_blankline").setup({
                -- for example, context is off by default, use this to turn it on
                show_current_context = true,
                show_current_context_start = true
            })
        end
    })

    -- status line
    use({
        "hoob3rt/lualine.nvim",
        requires = {
            {"kyazdani42/nvim-web-devicons"}, {"ryanoasis/vim-devicons"}
        }
    })

    -- git integration:
    -- Git show information in files (author, insertions,)
    use("lewis6991/gitsigns.nvim")

    -- todo lists:
    use("vimwiki/vimwiki")

    -- latex
    use("lervag/vimtex")
    use("xuhdev/vim-latex-live-preview")

    --[[
    --snippet manager
    {'hrsh7th/vim-vsnip'},
    {'hrsh7th/vim-vsnip-integ'},
    --actual snippet
    {'rafamadriz/friendly-snippets'},
    {'J0rgeSerran0/vscode-csharp-snippets'},
    --]]

    use("ThePrimeagen/vim-be-good")

    -- Markdown Previewer
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end
    })

    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = {"markdown"} end,
        ft = {"markdown"}
    })
    -- use { 'mhartington/formatter.nvim' }
    -- Formatter
    use({
        "stevearc/conform.nvim",
        config = function() require("conform").setup() end
    })

    -- Jupyter integration
    use({"dccsillag/magma-nvim", run = ":UpdateRemotePlugins"})

    -- dap debugging
    use({
        "rcarriga/nvim-dap-ui",
        requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}
    })

    use({
        "stevearc/oil.nvim",
        requires = {"echasnovski/mini.nvim", "nvim-tree/nvim-web-devicons"}
    })

end)
