-- ──────────────────────────────────────────────────────────────
-- LSP setup (modern style — no lsp-zero, no deprecated lspconfig calls)
-- ──────────────────────────────────────────────────────────────

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Shared on_attach (was lsp_attach)
-- local on_attach = function(client, bufnr)
-- Default keymaps similar to what lsp-zero used to provide
local opts = { buffer = bufnr, noremap = true, silent = true }


-- end

-- Global diagnostic configuration (unchanged)
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- ──────────────────────────────────────────────────────────────
-- Mason + mason-lspconfig (installs & sets up servers)
-- ──────────────────────────────────────────────────────────────

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = { "ts_ls", "rust_analyzer", "gopls" },
})

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then return end

		-- vim.notify("LSP attached: " .. client.name, vim.log.levels.INFO)

		local bufnr = args.buf
		local opts = { buffer = bufnr, noremap = true, silent = true }


		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
		vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
		vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)


		if client:supports_method("textDocument/formatting") then
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
			})
		end
	end
})

-- Individual servers that are **not** managed by mason-lspconfig
-- (or you want custom settings / you install them manually)
-- require("lspconfig").vala_ls.setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })

-- Optional: keep fidget for LSP progress
require("fidget").setup()

-- Optional: keep luasnip vscode loader (unrelated to LSP deprecation)
require("luasnip.loaders.from_vscode").lazy_load()

-- Optional: DAP (unchanged)
require("mason-nvim-dap").setup({
	handlers = {},
})
require('fidget').setup()
