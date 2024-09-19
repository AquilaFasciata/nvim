local lsp_zero = require('lsp-zero')

local lsp_attach = function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
	lsp_zero.buffer_autoformat()
end

lsp_zero.extend_lspconfig({
  lsp_attach = lsp_attach,
})


require("luasnip.loaders.from_vscode").lazy_load()
require('mason').setup({})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here 
  -- with the ones you want to install
  ensure_installed = {'ts_ls', 'rust_analyzer', 'gopls'},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require'lspconfig'.cssls.setup {
  capabilities = capabilities,
}
