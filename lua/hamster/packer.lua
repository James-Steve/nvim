vim.cmd.packadd("packer.nvim")

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    -- dotenv
    use("SergioRibera/cmp-dotenv")

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
        -- branch = "v1.x",
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

    -- omnisharp replacement
    use({"seblyng/roslyn.nvim", requires = {"tris203/rzls.nvim"}})

    use('ionide/Ionide-vim')
    -- use("WillEhrendreich/Ionide-Nvim")
    use("rafamadriz/friendly-snippets")
    use({"L3MON4D3/LuaSnip", dependencies = {"rafamadriz/friendly-snippets"}})
    use("mfussenegger/nvim-jdtls")
    -- ====================================================================
    -- NEED to integrate these
    -- ==================================================================

    -- use("luisiacc/gruvbox-baby", {"branch : main"})
    use {"ellisonleao/gruvbox.nvim"}
    use {"olimorris/onedarkpro.nvim"}

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
    use("sindrets/diffview.nvim")
    use("isakbm/gitgraph.nvim")

    -- todo lists:
    -- use("vimwiki/vimwiki")

    -- latex
    use("lervag/vimtex")
    use("xuhdev/vim-latex-live-preview")
    use("Ron89/thesaurus_query.vim")

    --[[
    --snippet manager
    {'hrsh7th/vim-vsnip'},
    {'hrsh7th/vim-vsnip-integ'},
    --actual snippet
    {'rafamadriz/friendly-snippets'},
    {'J0rgeSerran0/vscode-csharp-snippets'},
    --]]

    use("ThePrimeagen/vim-be-good")

    -- install without yarn or npm
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

    -- File Browsing, Creation, Editting
    use({
        "stevearc/oil.nvim",
        requires = {"echasnovski/mini.nvim", "nvim-tree/nvim-web-devicons"}
    })

    -- datbase
    use({
        "tpope/vim-dadbod",
        requires = {
            "kristijanhusak/vim-dadbod-completion",
            "kristijanhusak/vim-dadbod-ui", "tpope/vim-dotenv"
        }
    })

    -- dmbl database design file, syntax highlighting
    use({"nanotee/sqls.nvim"})
    use({"jidn/vim-dbml"})
    -- Surround
    use({
        "kylechui/nvim-surround",
        tag = "*" -- Use for stability; omit to use `main` branch for the latest features
    })

    -- keymapping
    use({
        "tris203/hawtkeys.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter"
        },
        config = {
            -- an empty table will work for default config
            leader = " ", -- the key you want to use as the leader, default is space
            homerow = 2, -- the row you want to use as the homerow, default is 2
            powerFingers = {2, 3, 6, 7}, -- the fingers you want to use as the powerfingers, default is {2,3,6,7}
            keyboardLayout = "qwerty", -- the keyboard layout you use, default is qwerty
            customMaps = {
                --- EG local map = vim.api
                --- map.nvim_set_keymap('n', '<leader>1', '<cmd>echo 1')
                {
                    ["map.nvim_set_keymap"] = { -- name of the expression
                        modeIndex = "1", -- the position of the mode setting
                        lhsIndex = "2", -- the position of the lhs setting
                        rhsIndex = "3", -- the position of the rhs setting
                        optsIndex = "4", -- the position of the index table
                        method = "dot_index_expression" -- if the function name contains a dot
                    }
                },
                --- EG local map2 = vim.api.nvim_set_keymap
                ["map2"] = { -- name of the function
                    modeIndex = 1, -- if you use a custom function with a fixed value, eg normRemap, then this can be a fixed mode eg 'n'
                    lhsIndex = 2,
                    rhsIndex = 3,
                    optsIndex = 4,
                    method = "function_call"
                },
                -- If you use whichkey.register with an alias eg wk.register
                ["wk.register"] = {method = "which_key"},
                -- If you use lazy.nvim's keys property to configure keymaps in your plugins
                ["lazy"] = {method = "lazy"}
            },
            highlights = { -- these are the highlight used in search mode
                HawtkeysMatchGreat = {fg = "green", bold = true},
                HawtkeysMatchGood = {fg = "green"},
                HawtkeysMatchOk = {fg = "yellow"},
                HawtkeysMatchBad = {fg = "red"}
            }
            --- if you use functions, or whichkey, or lazy to map keys
            --- then please see the API below for options
        }
    })
    use({
        "amitds1997/remote-nvim.nvim",
        requires = {
            "nvim-lua/plenary.nvim", -- For standard functions
            "MunifTanjim/nui.nvim", -- To build the plugin UI
            "nvim-telescope/telescope.nvim" -- For picking b/w different remote methods
        }
    })

    use({
        'MeanderingProgrammer/render-markdown.nvim',
        after = {'nvim-treesitter'},
        requires = {'nvim-mini/mini.nvim', opt = true} -- if you use the mini.nvim suite
        -- requires = { 'nvim-mini/mini.icons', opt = true }, -- if you use standalone mini plugins
        -- requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
    })

    use {
        'https://gitlab.com/itaranto/preview.nvim',
        tag = '*',
    }
    use ("aklt/plantuml-syntax")

end)
