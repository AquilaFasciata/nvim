return {
	{ 'neovim/nvim-lspconfig', version = '^2.0.0'},
	{ 'williamboman/mason.nvim' },
	{ 'williamboman/mason-lspconfig.nvim' },
	{
		'L3MON4D3/LuaSnip',
		build = "make install_jsregexp"
	},
	{ 'saadparwaiz1/cmp_luasnip' },
	{ 'VonHeikemen/lsp-zero.nvim', branch = 'v4.x' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/nvim-cmp' },
	{ 'hrsh7th/cmp-path' },
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		dependencies = {
			{ "rafamadriz/friendly-snippets" },
		}
	},
	{ 'saadparwaiz1/cmp_luasnip' },
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-nvim-lsp-signature-help' },
	{
		"j-hui/fidget.nvim",
		opts = {
			-- options
		},
	}
}
