vim.g.db_ui_execute_on_save = 0
vim.g.db_ui_save_location = 'Database'
vim.g.db_ui_dotenv_variable_prefix = 'dbui'
local dot = require("hamster.env")

dot.load_dotenv(vim.fn.expand('$HOME/.config/env/dbs.env'))
local name = dot.get("PVProjDevName","obama")
local connection =  dot.get("PVProjDev","obama")
vim.g.dbs = {{name = name, url = connection}}
