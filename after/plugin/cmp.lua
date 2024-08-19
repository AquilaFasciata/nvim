local cmp = require("cmp")

cmp.setup({
	snippet = {
    expand = function(args)
			require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<Enter>"] = cmp.mapping(function(fallback)
      -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
      if cmp.visible() then
        local entry = cmp.get_selected_entry()
        if not entry then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        end
        cmp.confirm()
      else
        fallback()
      end
    end, {"i","s","c",}),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer" },
		{ name = 'nvim_lsp_signature_help' },
  }),
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require'lspconfig'.rust_analyzer.setup {
	capabilities = capabilities,
}
