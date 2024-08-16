return {
	{'neovim/nvim-lspconfig'},
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
	{'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp"
	},
	{'saadparwaiz1/cmp_luasnip'},
	{'hrsh7th/cmp-buffer'},
	{'hrsh7th/cmp-nvim-lsp-signature-help'},
}
