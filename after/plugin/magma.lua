local opts = {buffer = bfnr, remap = false}
vim.api.nvim_create_autocmd('BufEnter',
{
    pattern = {"*.py"},
    group = group,
    callback = function(env)
        vim.keymap.set('n', "Tk", function() vim.cmd "vim_exec('MagmaEvaluateOperator', v:true)" end, opts)
        vim.keymap.set('n', "TK", function() vim.cmd "MagmaEvaluateLine" end, opts)
        vim.keymap.set('n', "Tv", function() vim.cmd "MagmaEvaluateVisual" end, opts)
        vim.keymap.set('n', "Tc", function() vim.cmd "MagmaReevaluateCell" end, opts)
        vim.keymap.set('n', "Td", function() vim.cmd "MagmaDelete" end, opts)
        vim.keymap.set('n', "To", function() vim.cmd "MagmaShowOutput" end, opts)
        vim.cmd[[
    :MagmaInit python3
    :MagmaEvaluateArgument a=5
    ]]
end
})
