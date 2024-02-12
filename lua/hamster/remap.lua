vim.g.mapleader = "\\"
--vim remaps default is non recursive
--
--
--Opens netrw (file tree explorer)
vim.keymap.set("n", "<space>f", vim.cmd.Ex)

--Code tab stops cleanup
--vim.keymap.set("n", "<F7>",  "gg=G")
--vim.keymap.set("n", "<C-7>",  "gg=G")


--moving lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
--moving a single line in normal mode
vim.keymap.set("n","<C-Down>",":m .+1<CR>")
vim.keymap.set("n","<C-Up>",":m .-2<CR>")

--yanks to end of line
vim.keymap.set("n","Y", "y$")
--Pastes from yank register
vim.keymap.set("n", "P", "\"0p")
--alows you to replace highlighted words in visual mode without losing word in yank
vim.keymap.set("x", "<leader>p", "\"_P")
--adds yank to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", "\"+y")

--move down or up 1/2 pages with cursor staying in one place
vim.keymap.set("n", "<C-d>", "<C-d>zz")
--keeps search terms in the middle (you dont have look where your cursor is)
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

--dont press capital q
vim.keymap.set("n", "Q", "<nop>")

--quick fix list navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

--replaces word you were one
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

--makes file excutable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

--sources current file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)


--undo Break points
vim.keymap.set("n","<space>," ,"<c-g>u")
vim.keymap.set("n", ".", ".<c-g>u")
vim.keymap.set("n","!", "!<c-g>u")
vim.keymap.set("n","?", "?<c-g>u")

--alows to write / files
vim.keymap.set('c', 'w!!', "<esc>:lua require'utils'.sudo_write()<CR>", { silent = true })
--[[
line 1 
line 2 
line 3
--]]
