CustomOilBar = function()
    local path = vim.fn.expand "%"
    path = path:gsub("oil://", "")

    return "  " .. vim.fn.fnamemodify(path, ":.")
end
local oil = require("oil")
oil.setup({

    columns = {"icon"},
    keymaps = {
        ["<C-h>"] = false,
        -- ["<C-l>"] = false,
        ["<C-k>"] = false,
        ["<C-j>"] = false,
        -- M is alt
        ["<M-h>"] = "actions.select_split",
        ["<C-l>"] = "actions.refresh",
        ["<C-q>"] = "actions.close"
    },
    win_options = {winbar = "%{v:lua.CustomOilBar()}"},
    view_options = {show_hidden = true}
})

-- Open parent directory in current window
vim.keymap.set("n", "-", "<CMD>Oil<CR>", {desc = "Open parent directory"})

-- Open parent directory in floating window
vim.keymap.set("n", "<space>-", oil.toggle_float)

-- When neovim opened with arguments folder/anotherfolder/project/?
-- project directory will be made the working directory
-- and then open oil
local group_cdpwd = vim.api.nvim_create_augroup("group_cdpwd", {clear = true})
vim.api.nvim_create_autocmd("VimEnter", {
    group = group_cdpwd,
    callback = function()
        local bufname = vim.api.nvim_get_current_buf()
        local filename = vim.api.nvim_buf_get_name(bufname)
        if (vim.fn.fnamemodify(filename, ":t") == "?") then
            local path = vim.fn.fnamemodify(filename, ":p:h")
            vim.api.nvim_set_current_dir(path)
            vim.schedule(function()
                vim.api.nvim_buf_delete(bufname, {force = true})
            end)
            vim.defer_fn(function() oil.open() end, 10)

        end
    end
})
