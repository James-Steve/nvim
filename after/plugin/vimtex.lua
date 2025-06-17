vim.g.vimtex_view_method = "okular"
vim.g.livepreview_previewer = "okular"

--[[
vim.g.vimtex_compiler_generic = {
   command= 'ls @tex | entr -n -c tectonic /_ --synctex --keep-logs',}
   --]]

vim.g.vimtex_compiler_latexmk = {
    executable = 'latexmk',
    aux_dir = 'Auxiliary',
    out_dir = 'Output',
    options = {
        '-pdf', '-xelatex', '-synctex=1', '-interaction=nonstopmode',
        '-shell-escape', '-verbose', '-file-line-error'
    }
}
vim.g.tq_mthesaur_file = "~/Documents/mthesaur.txt"

--[[
Mappings
<leader>ll start compiling in continous mode
<leader>lt toggle navigation bar

--]]
