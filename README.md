# James Neovim Configuration

<!--toc:start-->
- [James Neovim Configuration](#james-neovim-configuration)
  - [Tools and Plugins](#tools-and-plugins)
  - [Directory Structure and Function](#directory-structure-and-function)
<!--toc:end-->

Welcome to my Custom Neovim Configuration
## Tools and Plugins
| Tool Name           | Function                     |
| ---------           | --------                     |
| lsp-zero            | Lsp Server Manger            |
| Mason               | Lsp Installer                |
| cmp                 | Autocompletion Engine        |
| luasnip             | Snippet Engine               |
| Telescope           | File browser                 |
| Treesitter          | Syntax Highlighting           |
| Harpoon             | Buffer to Keyboard shortcuts |
| Gruvbox             | Colour Scheme                |
| Nvim Autopairs      | Automatic pair matching      |
| indent-blanklink    | Indentation marker           |
| lualine             | Status line                  |
| gitsigns            | Git Integration              |
| vimwiki             | Dairy/To-do Lists             |
| vimtex              | Latex Previewer              |
| markdown-preview    | Markdown Previewer           |

## Directory Structure and Function
├── after &emsp; &emsp; &emsp; &emsp; &emsp; &emsp;&emsp; All files in this directory are excuted after plugins are loaded \
│   └── plugin  &emsp; &emsp; &emsp; &emsp; &emsp; Plugin Directory \
│       ├── Lsp.lua &emsp; &emsp; &emsp; &emsp; &nbsp; Lsp-Server, Lua-Snip, cmp, mason and Lsp-Zero Configuration and Shortcuts  \
│       ├── colorscheme.lua \
│       ├── gitsigns.lua  &emsp; &emsp; &emsp; Git Ident marking and Intregration Configuration and Shortcuts\
│       ├── harpoon.lua  \
│       ├── indent.lua \
│       ├── statusline.lua \
│       ├── telescope.lua \
│       ├── treesitter.lua \
│       ├── undotree.lua \
│       └── vimtex.lua \
├── init.lua &emsp; &emsp; &emsp; &emsp; &emsp; &emsp;First file executed and specifies which user settings to use\
├── lua &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; All files in this directory are executed before plugins are loaded\
│   └── hamster &emsp; &emsp; &emsp; &emsp; User Files\
│       ├── init.lua&emsp; &emsp; &emsp; &emsp; &emsp;Which Files to execute in hamster directory \
│       ├── packer.lua &emsp; &emsp; &emsp; &nbsp;Plugins for packer to install\
│       ├── remap.lua &emsp; &emsp; &emsp; &nbsp;Remapping of shortcuts\
│       └── set.lua &emsp; &emsp; &emsp; &emsp; &nbsp;  Initial Settings\
├── plugin \
│   └── packer_compiled.lua \
└── usefull-commands.txt 
