vim.opt.splitright = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

--Split Bar
--vim.opt.colorcolumn = "80"

vim.api.nvim_create_user_command('Redir', function(ctx)
    local lines = vim.split(vim.api.nvim_exec(ctx.args, true), '\n',
                            {plain = true})
    vim.cmd('vnew')
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.opt_local.modified = false
end, {nargs = '+', complete = 'command'})
-- :Redir lua=vim.tbl_keys(package.loaded)

vim.g["fsharp#show_signature_on_cursor_move"] = 0
vim.g["fsharp#lsp_auto_setup"] = 0
vim.g["fsharp#workspace_mode_peek_deep_level"] = 4

vim.api.nvim_create_user_command("FSharpRefreshCodeLens", function()
  vim.lsp.codelens.refresh()
  print "[FSAC] Refreshing CodeLens"
end, {
  bang = true,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.puml", "*.pu" },
  callback = function()
    vim.bo.filetype = "plantuml"
  end,
})
vim.g.markdown_fenced_languages = {
  "bash=sh",
  "javascript",
  "js=javascript",
  "json",
  "python",
  "lua",
  "plantuml",
}
