--vimtext settings
--[[
" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note that most plugin managers will do this automatically.
filetype plugin indent on

" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements" for more
" info).
syntax enable

" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_method = 'zathura'

" Or with a generic interface:
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
let g:vimtex_compiler_method = 'latexrun'

" Most VimTeX mappings rely on localleader and this can be changed with the
" following line. The default is usually fine and is the symbol "\".
let maplocalleader = ","
--]]
--vim.g.vimtex_view_method="zathura"
--let g:livepreview_previewer = 'evince'
vim.g.vimtex_view_method = "okular.exe"
vim.g.livepreview_previewer = "okular.exe"
--vim.g.vimtex_compiler_latexmk.aux_dir="aux/"
--vim.g.vimtex_compiler_latexmk.out_dir="out/"
--vim.g.vimtex_compiler_latexmk = {aux_dir="aux/", out_dir="out/"}
vim.g.vimtex_compiler_latexmk = {
    aux_dir = 'aux',
    out_dir = 'out',
    callback = 1,
    continuous = 1,
    executable = 'latexmk',
    hooks = {},
    options = {
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
    },
}


--[[
    let g:vimtex_compiler_latexmk = {
        \ 'aux_dir' : '',
        \ 'out_dir' : '',
        \ 'callback' : 1,
        \ 'continuous' : 1,
        \ 'executable' : 'latexmk',
        \ 'hooks' : [],
        \ 'options' : [
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}
        --]]
