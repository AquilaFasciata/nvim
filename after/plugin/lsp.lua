local lsp_zero = require('lsp-zero')

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lsp_attach = function(client, bufnr)
	lsp_zero.default_keymaps({ buffer = bufnr })
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
	ensure_installed = { 'ts_ls', 'rust_analyzer', 'gopls' },
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({
				capabilities = capabilities
			})
		end,
	},
})

-- require 'lspconfig'.cssls.setup {
-- 	capabilities = capabilities,
-- }
-- require('lspconfig').rust_analyzer.setup {
-- 	capabilities = capabilities,
-- }
-- require('lspconfig').gopls.setup {
-- 	capabilities = capabilities,
-- }
-- require('lspconfig').arduino_language_server.setup {
-- 	capabilities = capabilities,
-- }
-- require('lspconfig').kotlin_language_server.setup {
-- 	capabilities = capabilities,
-- }
require('lspconfig').vala_ls.setup {
	capabilities = capabilities,
}

require('fidget').setup()
