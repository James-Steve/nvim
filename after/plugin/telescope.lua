local tel = require('telescope')
local path_actions = require('telescope_insert_path')

tel.setup {
    defaults = {
        mappings = {
      n = {
        -- E.g. Type `[i`, `[I`, `[a`, `[A`, `[o`, `[O` to insert relative path and select the path in visual mode.
        -- Other mappings work the same way with a different prefix.
        --["["] = path_actions.insert_reltobufpath_visual,
        --["]"] = path_actions.insert_abspath_visual,
        --["{"] = path_actions.insert_reltobufpath_insert,
        --["}"] = path_actions.insert_abspath_insert,
        ["pr"] = path_actions.insert_reltobufpath_normal,
        ["pa"] = path_actions.insert_abspath_normal,
	-- If you want to get relative path that is relative to the cwd, use
	-- `relpath` instead of `reltobufpath`
        -- You can skip the location postfix if you specify that in the function name.
        -- ["<C-o>"] = path_actions.insert_relpath_o_visual,
      }
    },
        file_ignore_patterns = { ".git/objects", ".git/heads", ".git/hooks", ".git/index", ".git/*HEAD*", ".git/logs", ".git/*refs*", ".git/info", ".git/packed*", ".git/COMMITS*",
            ".git/description", ".git/ORIG*", ".git/FETCH*" }
    }
}
local opts = {
    file_ignore_patterns = { ".git/", ".git/*" }
}

local builtin = require('telescope.builtin')
tel.load_extension("file_browser")


vim.keymap.set('n', '<Leader>ff', function()
    builtin.find_files({ hidden = true, file_ignore_pattern = { ".git/*", ".git/" } })
end
    , {})
--Telescoping in ~/.config/nvim
vim.keymap.set('n', '<Leader>rc', function()
    builtin.find_files({
        prompt_title = "<VimRC>",
        cwd = "~/.config/nvim",
        hidden = true,
    })
end
    , {})
--Telescoping in ~/.config/LatexStuff/
vim.keymap.set('n', '<Leader>rl', function()
    builtin.find_files({
        prompt_title = "<Latex>",
        cwd = "~/.config/LatexStuff",
        hidden = true,
    })
end
    , {})
--File Browser
vim.keymap.set('n', '<Leader>bb', tel.extensions.file_browser.file_browser, {})
--Buffers
vim.keymap.set('n', '<Leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<Leader>fc', builtin.git_commits, {})
vim.keymap.set('n', '<Leader>fg', function()
    builtin.live_grep({
        vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-u' } })
end, {})
vim.keymap.set('n', '<Leader>fs', builtin.git_status, {})
--Lists commits for the current buffer
vim.keymap.set('n', '<Leader>fbc', builtin.git_bcommits, {})
