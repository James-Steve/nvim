local cols = {
    bg = "#000000",
    fg = "#abb2bf",
    red = "#ef596f",
    orange = "#d19a66",
    yellow = "#e5c07b",
    green = "#89ca78",
    cyan = "#2bbac5",
    blue = "#61afef",
    purple = "#d55fde",
    white = "#abb2bf",
    black = "#000000",
    gray = "#434852",
    highlight = "#e2be7d",
    comment = "#7f848e",
    none = "NONE",
}
require("onedarkpro").setup({
    highlights = {
        ["@markup.heading.1.markdown"] = {fg = cols.green, bold = true},
        ["@markup.heading.2.markdown"] = {fg = cols.purple},
        ["@markup.heading.3.markdown"] = {fg = cols.cyan},
        ["@markup.heading.4.markdown"] = {fg = cols.red},
        ["@markup.heading.5.markdown"] = {fg = cols.red},
        ["@markup.heading.6.markdown"] = {fg = cols.red},
        ["@markup.list"] = {fg = cols.green},
        ["@markup.list.unchecked"] = {fg = cols.red},
        ["@markup.list.checked"] = {fg = cols.blue},
        ["@markup.list.markdown"] = {fg = cols.yellow},
    },
    options = {
    transparency = false
  }
})
vim.cmd("colorscheme onedark_dark")
