local lsp_zero = require('lsp-zero')

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lsp_attach = function(client, bufnr)
	lsp_zero.default_keymaps({ buffer = bufnr })
	lsp_zero.buffer_autoformat()
	vim.keymap.set('v', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
end

vim.diagnostic.config({
  virtual_text = true, -- Enable inline error messages
  signs = true,        -- Keep signs (e.g., in the gutter) enabled
  underline = true,    -- Keep squiggles enabled
  update_in_insert = false, -- Prevent updates while typing (optional)
  severity_sort = true,     -- Sort by severity (optional)
})

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


require("mason-nvim-dap").setup({
	handlers = {},
})

-- require 'lspconfig'.cssls.setup {
-- 	capabilities = capabilities,
-- }
require('lspconfig').rust_analyzer.setup {
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      diagnostics = { enabled = true },
      cargo = { allFeatures = true }, -- Ensure full analysis
      checkOnSave = true,
    },
  },
  on_attach = function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
    lsp_zero.buffer_autoformat()
    vim.keymap.set('v', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', { buffer = bufnr, noremap = true, silent = true })
    -- Explicitly handle diagnostics
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        underline = true,
        signs = true,
      }
    )
  end,
}
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
