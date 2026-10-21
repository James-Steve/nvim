local conform = require("conform")

conform.setup({
    -- formatters = {["sqlfmt"] = {env = { SQLFMT_DIALECT = "clickhouse",}}},
    formatters = {
        ["tex-fmt"] = {
            append_args = {"-l", 140}
        },
        ["sql_formatter"] = {args = {"-l", "postgresql", "$FILENAME"}},
        ["pg_format"] = {
            command = "pg_format",
            -- args = { "--format-type", "--sapces", "2", "--keyword-case", "2", "--type-case", "3", "--Wrap-after", "50", "--no-space-function", "$FILENAME" }
            -- args = { "--format-type", "--spaces", 2, "--keyword-case", 2, "--type-case", 3, "--wrap-after", 200, "--no-space-function", "--no-extra-line", "$FILENAME" }
            args = {
                "--format-type", "--spaces", 4, "--keyword-case", 2,
                "--type-case", 3, "--no-space-function", "--no-extra-line",
                "--tabs", "--keep-newline", "$FILENAME"
            }
            -- args = {"-t -s 4 -u 2 -U 3 -W 50 --no-space-function UpdatePlant.sql"},
        }
    },
    formatters_by_ft = {
        javascript = {"prettier"},
        typescript = {"prettier"},
        javascriptreact = {"prettier"},
        typescriptreact = {"prettier"},
        svelte = {"prettier"},
        css = {"prettier"},
        html = {"prettier"},
        json = {"prettier"},
        yaml = {"prettier"},
        markdown = {"prettier"},
        graphql = {"prettier"},
        --lua = {"lua-format"},
        lua = {"stylua"},
        python = {"isort", "black"},
        xml = {"xmlformatter"},
        -- python = {"pyink"}
        -- sql = {"sql_formatter"}
        sql = {"pg_format"},
        -- sql = {"sqlfmt"}
        latex = {"tex-fmt"},
        tex = {"tex-fmt"},
        eruby = {"erb_format"}

    }
    -- format_on_save = {lsp_fallback = false, async = false, timeout_ms = 1000}
})

--conform.formatters.texfmt = {append_args = {"-l", 100}}
vim.keymap.set({"n", "v"}, "<leader>mp", function()
    conform.format({lsp_fallback = true, async = false, timeout_ms = 1000})
end, {desc = "Format file or range (in visual mode)"})
