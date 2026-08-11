-- HTML cleanup for Roslyn hover docs
local function decode_html_entities(text)
	return text:gsub("&nbsp;", " ")
		:gsub("&lt;", "<")
		:gsub("&gt;", ">")
		:gsub("&quot;", '"')
		:gsub("&#39;", "'")
		:gsub("&amp;", "&") -- last, so &amp;lt; doesn't become 
end

local function strip_html_tags(text)
	return text:gsub("<br%s*/?>", "\n")
		:gsub("</p>", "\n")
		:gsub("<p[^>]*>", "")
		:gsub("<li[^>]*>", "\n- ")
		:gsub("</li>", "")
		:gsub("<[^>]+>", " ")
		:gsub(" +", " ")
		:gsub(" ?\n ?", "\n")
end

local function clean_hover(text)
	return strip_html_tags(decode_html_entities(text))
end

local function clean_contents(contents)
	if type(contents) == "string" then
		return clean_hover(contents)
	elseif type(contents) == "table" then
		if contents.value then
			contents.value = clean_hover(contents.value)
		end
		for i, item in ipairs(contents) do
			contents[i] = clean_contents(item)
		end
	end
	return contents
end

local function roslyn_hover(err, result, ctx, config)
	if result and result.contents then
		result.contents = clean_contents(result.contents)
	end
	return vim.lsp.handlers.hover(err, result, ctx, config)
end

vim.o.winborder = "rounded"
vim.filetype.add({ extension = { razor = "razor", cshtml = "razor" } })

require("roslyn").setup({
	filewatching = "auto",
	broad_search = false,
	lock_target = false,
	choose_target = nil,
	ignore_target = nil,
})

vim.lsp.config("roslyn", {
	handlers = { ["textDocument/hover"] = roslyn_hover },
	settings = {
		["csharp|completion"] = {
			dotnet_provide_regex_completions = true,
			dotnet_show_completion_items_from_unimported_namespaces = false,
			dotnet_show_name_completion_suggestions = true,
		},
		["csharp|inlay_hints"] = {
			csharp_enable_inlay_hints_for_implicit_object_creation = true,
			csharp_enable_inlay_hints_for_implicit_variable_types = true,
			csharp_enable_inlay_hints_for_lambda_parameter_types = true,
			csharp_enable_inlay_hints_for_types = true,
			dotnet_enable_inlay_hints_for_indexer_parameters = true,
			dotnet_enable_inlay_hints_for_literal_parameters = true,
			dotnet_enable_inlay_hints_for_object_creation_parameters = true,
			dotnet_enable_inlay_hints_for_other_parameters = true,
			dotnet_enable_inlay_hints_for_parameters = true,
			dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = false,
			dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = false,
			dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = false,
		},
		["csharp|code_lens"] = { dotnet_enable_references_code_lens = true },
	},
})

vim.lsp.enable("roslyn")
