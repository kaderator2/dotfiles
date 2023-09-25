return { 
	-- Plugins will be added here accordingly.
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.3',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{ 'rose-pine/neovim', name = 'rose-pine' },
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
	{"ThePrimeagen/harpoon"},
	{"mbbill/undotree"},
	{"tpope/vim-fugitive"},
	{"williamboman/mason.nvim"},
	{"ThePrimeagen/vim-be-good"},
	{"williamboman/mason-lspconfig"},
	{
		{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},

		--- Uncomment these if you want to manage LSP servers from neovim
		-- {'williamboman/mason.nvim'},
		-- {'williamboman/mason-lspconfig.nvim'},

		-- LSP Support
		{
			'neovim/nvim-lspconfig',
			dependencies = {
				{'hrsh7th/cmp-nvim-lsp'},
			},
		},

		-- Autocompletion
		{
			'hrsh7th/nvim-cmp',
			dependencies = {
				{'L3MON4D3/LuaSnip'},
			}
		}
	}
}

