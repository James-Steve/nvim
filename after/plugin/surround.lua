sur = require("nvim-surround")
cfg = require("nvim-surround.config")
sur.setup({
	aliases = {
		["a"] = ">",
		["b"] = ")",
		["B"] = "}",
		["r"] = "]",
		["q"] = { '"', "'", "`" },
		["s"] = { "}", "]", ")", ">", '"', "'", "`" },
	},
	highlight = {
		duration = 0,
	},
	move_cursor = "begin",
	indent_lines = function(start, stop)
		local b = vim.bo
		-- Only re-indent the selection if a formatter is set up already
		if start < stop and (b.equalprg ~= "" or b.indentexpr ~= "" or b.cindent or b.smartindent or b.lisp) then
			vim.cmd(string.format("silent normal! %dG=%dG", start, stop))
			require("nvim-surround.cache").set_callback("")
		end
	end,
})

--The three "core" operations of add/delete/change can be done with the keymaps
--ys{motion}{char}, ds{char}, and cs{target}{replacement}
--, respectively. For the following examples, * will denote the cursor position:
--[[
--   Old text                    Command         New text
--------------------------------------------------------------------------------
    surr*ound_words             ysiw)           (surround_words)
    *make strings               ys$"            "make strings"
    [delete ar*ound me!]        ds]             delete around me!
    remove <b>HTcfgL t*ags</b>    dst             remove HTcfgL tags
    'change quot*es'            cs'"            "change quotes"
    <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
    delete(functi*on calls)     dsf             function calls
--]]
vim.keymap.set("i", "<C-g>s", "<Plug>(nvim-surround-insert)", {
	desc = "Add a surrounding pair around the cursor (insert mode)",
})
vim.keymap.set("i", "<C-g>S", "<Plug>(nvim-surround-insert-line)", {
	desc = "Add a surrounding pair around the cursor, on new lines (insert mode)",
})
vim.keymap.set("n", "ys", "<Plug>(nvim-surround-normal)", {
	desc = "Add a surrounding pair around a motion (normal mode)",
})
vim.keymap.set("n", "yss", "<Plug>(nvim-surround-normal-cur)", {
	desc = "Add a surrounding pair around the current line (normal mode)",
})
vim.keymap.set("n", "yS", "<Plug>(nvim-surround-normal-line)", {
	desc = "Add a surrounding pair around a motion, on new lines (normal mode)",
})
vim.keymap.set("n", "ySS", "<Plug>(nvim-surround-normal-cur-line)", {
	desc = "Add a surrounding pair around the current line, on new lines (normal mode)",
})
vim.keymap.set("x", "S", "<Plug>(nvim-surround-visual)", {
	desc = "Add a surrounding pair around a visual selection",
})
vim.keymap.set("x", "gS", "<Plug>(nvim-surround-visual-line)", {
	desc = "Add a surrounding pair around a visual selection, on new lines",
})
vim.keymap.set("n", "ds", "<Plug>(nvim-surround-delete)", {
	desc = "Delete a surrounding pair",
})
vim.keymap.set("n", "cs", "<Plug>(nvim-surround-change)", {
	desc = "Change a surrounding pair",
})
vim.keymap.set("n", "cS", "<Plug>(nvim-surround-change-line)", {
	desc = "Change a surrounding pair, putting replacements on new lines",
})
--old setup
--[[
	surrounds = {
		["("] = {
			add = { "( ", " )" },
			find = function()
				return cfg.get_selection({ motion = "a(" })
			end,
			delete = "^(. ?)().-( ?.)()$",
		},
		[")"] = {
			add = { "(", ")" },
			find = function()
				return cfg.get_selection({ motion = "a)" })
			end,
			delete = "^(.)().-(.)()$",
		},
		["{"] = {
			add = { "{ ", " }" },
			find = function()
				return cfg.get_selection({ motion = "a{" })
			end,
			delete = "^(. ?)().-( ?.)()$",
		},
		["}"] = {
			add = { "{", "}" },
			find = function()
				return cfg.get_selection({ motion = "a}" })
			end,
			delete = "^(.)().-(.)()$",
		},
		["<"] = {
			add = { "< ", " >" },
			find = function()
				return cfg.get_selection({ motion = "a<" })
			end,
			delete = "^(. ?)().-( ?.)()$",
		},
		[">"] = {
			add = { "<", ">" },
			find = function()
				return cfg.get_selection({ motion = "a>" })
			end,
			delete = "^(.)().-(.)()$",
		},
		["["] = {
			add = { "[ ", " ]" },
			find = function()
				return cfg.get_selection({ motion = "a[" })
			end,
			delete = "^(. ?)().-( ?.)()$",
		},
		["]"] = {
			add = { "[", "]" },
			find = function()
				return cfg.get_selection({ motion = "a]" })
			end,
			delete = "^(.)().-(.)()$",
		},
		["'"] = {
			add = { "'", "'" },
			find = function()
				return cfg.get_selection({ motion = "a'" })
			end,
			delete = "^(.)().-(.)()$",
		},
		['"'] = {
			add = { '"', '"' },
			find = function()
				return cfg.get_selection({ motion = 'a"' })
			end,
			delete = "^(.)().-(.)()$",
		},
		["`"] = {
			add = { "`", "`" },
			find = function()
				return cfg.get_selection({ motion = "a`" })
			end,
			delete = "^(.)().-(.)()$",
		},
		["i"] = { -- TODO: Add find/delete/change functions
			add = function()
				local left_delimiter = cfg.get_input("Enter the left delimiter: ")
				local right_delimiter = left_delimiter and cfg.get_input("Enter the right delimiter: ")
				if right_delimiter then
					return { { left_delimiter }, { right_delimiter } }
				end
			end,
			find = function() end,
			delete = function() end,
		},
		["t"] = { --HTcfgL
			add = function()
				local user_input = cfg.get_input("Enter the HTcfgL tag: ")
				if user_input then
					local element = user_input:match("^<?([^%s>]*)")
					local attributes = user_input:match("^<?[^%s>]*%s+(.-)>?$")

					local open = attributes and element .. " " .. attributes or element
					local close = element

					return { { "<" .. open .. ">" }, { "</" .. close .. ">" } }
				end
			end,
			find = function()
				return cfg.get_selection({ motion = "at" })
			end,
			delete = "^(%b<>)().-(%b<>)()$",
			change = {
				target = "^<([^%s<>]*)().-([^/]*)()>$",
				replacement = function()
					local user_input = cfg.get_input("Enter the HTcfgL tag: ")
					if user_input then
						local element = user_input:match("^<?([^%s>]*)")
						local attributes = user_input:match("^<?[^%s>]*%s+(.-)>?$")

						local open = attributes and element .. " " .. attributes or element
						local close = element

						return { { open }, { close } }
					end
				end,
			},
		},
		["T"] = {
			add = function()
				local user_input = cfg.get_input("Enter the HTcfgL tag: ")
				if user_input then
					local element = user_input:match("^<?([^%s>]*)")
					local attributes = user_input:match("^<?[^%s>]*%s+(.-)>?$")

					local open = attributes and element .. " " .. attributes or element
					local close = element

					return { { "<" .. open .. ">" }, { "</" .. close .. ">" } }
				end
			end,
			find = function()
				return cfg.get_selection({ motion = "at" })
			end,
			delete = "^(%b<>)().-(%b<>)()$",
			change = {
				target = "^<([^>]*)().-([^/]*)()>$",
				replacement = function()
					local user_input = cfg.get_input("Enter the HTcfgL tag: ")
					if user_input then
						local element = user_input:match("^<?([^%s>]*)")
						local attributes = user_input:match("^<?[^%s>]*%s+(.-)>?$")

						local open = attributes and element .. " " .. attributes or element
						local close = element

						return { { open }, { close } }
					end
				end,
			},
		},
		["f"] = {
			add = function()
				local result = cfg.get_input("Enter the function name: ")
				if result then
					return { { result .. "(" }, { ")" } }
				end
			end,
			find = function()
				if vim.g.loaded_nvim_treesitter then
					local selection = cfg.get_selection({
						query = {
							capture = "@call.outer",
							type = "textobjects",
						},
					})
					if selection then
						return selection
					end
				end
				return cfg.get_selection({ pattern = "[^=%s%(%){}]+%b()" })
			end,
			delete = "^(.-%()().-(%))()$",
			change = {
				target = "^.-([%w_]+)()%(.-%)()()$",
				replacement = function()
					local result = cfg.get_input("Enter the function name: ")
					if result then
						return { { result }, { "" } }
					end
				end,
			},
		},
		invalid_key_behavior = {
			-- By default, we ignore control characters for adding/finding because they are more likely typos than
			-- intentional. We choose NOT to for deletion, as users could have redefined the find key to something like
			-- ‘.-’. In this case we should still trim a character from each side, instead of early returning nil.
			add = function(char)
				if not char or char:find("%c") then
					return nil
				end
				return { { char }, { char } }
			end,
			find = function(char)
				if not char or char:find("%c") then
					return nil
				end
				return cfg.get_selection({
					pattern = vim.pesc(char) .. ".-" .. vim.pesc(char),
				})
			end,
			delete = function(char)
				if not char then
					return nil
				end
				return cfg.get_selections({
					char = char,
					pattern = "^(.)().-(.)()$",
				})
			end,
		},
	},
    --]]
