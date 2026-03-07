-- ──────────────────────────────────────────────────────────────
-- LSP setup (modern style — no lsp-zero, no deprecated lspconfig calls)
-- ──────────────────────────────────────────────────────────────

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Shared on_attach (was lsp_attach)
local on_attach = function(client, bufnr)
	-- Default keymaps similar to what lsp-zero used to provide
	local opts = { buffer = bufnr, noremap = true, silent = true }

	-- You can keep lsp-zero's default_keymaps style or define manually
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
	vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

	-- Your custom one
	vim.keymap.set('v', '<F4>', vim.lsp.buf.code_action, opts)

	-- Autoformat on save (like lsp_zero.buffer_autoformat)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})
	end
end

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

	handlers = {
		-- Default handler for most servers
		function(server_name)
			require("lspconfig")[server_name].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end,

		-- You can still override individual servers here if needed
		-- Example:
		-- ["lua_ls"] = function()
		--   require("lspconfig").lua_ls.setup({
		--     capabilities = capabilities,
		--     on_attach = on_attach,
		--     settings = { Lua = { ... } }
		--   })
		-- end,
	},
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
