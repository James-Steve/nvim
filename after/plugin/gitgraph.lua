graph = require('gitgraph')
opts = {
    symbols = {merge_commit = 'M', commit = '*'},
    format = {
        timestamp = '%H:%M:%S %d-%m-%Y',
        --fields = {'hash', 'timestamp', 'author', 'branch_name', 'tag'}
        fields = {'hash', 'branch_name', 'tag'}
    },
    hooks = {
        on_select_commit = function(commit)
            print('selected commit:', commit.hash)
        end,
        on_select_range_commit = function(from, to)
            print('selected range:', from.hash, to.hash)
        end
    }
}

graph.setup(opts)
vim.keymap.set("n", "<leader>gglog",
               function() graph.draw({}, {all = true, max_count = 5000}) end)
