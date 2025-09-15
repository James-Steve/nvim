 require('preview').setup({
     previewers_by_ft = {
         --[[
    markdown = {
      name = 'pandoc_wkhtmltopdf',
      renderer = { type = 'command', opts = { cmd = { 'zathura' } } },
    },
    --]]
    --[[
    plantuml = {
      name = 'plantuml_text',
      renderer = { type = 'buffer', opts = { split_cmd = 'vsplit' } },
    },
    --]]
    plantuml = {
      name = 'plantuml_svg',
      --renderer = { type = 'command', opts = { cmd = { 'eog' } } },
      renderer = { type = 'command', opts = { cmd = { 'qimgv' } } },
    },

    --[[
    groff = {
      name = 'groff_ms_pdf',
      renderer = { type = 'command', opts = { cmd = { 'zathura' } } },
    },
    --]]
  },
  previewers = {
    plantuml_svg = {
      --args = { '-pipe', '-tpng' },
      args = { '-pipe', '-tsvg' },
    },
  },
  render_on_write = true,

 })
