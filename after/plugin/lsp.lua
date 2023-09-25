local lspconfig = require("lspconfig")
local cmp = require('cmp')
local lsp_zero = require('lsp-zero')

-- Setup LSP servers
local servers = { 'tsserver', 'rust_analyzer' }
for _, server in ipairs(servers) do
	lspconfig[server].setup({
		on_attach = function(client, bufnr)
			local opts = { buffer = bufnr, remap = false }

			vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

			local function buf_set_keymap(...)
				vim.api.nvim_buf_set_keymap(bufnr, ...)
			end

			-- Key mappings
			buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
			buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
			buf_set_keymap('n', '<leader>vws', '<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
			buf_set_keymap('n', '<leader>vd', '<Cmd>lua vim.diagnostic.open_float()<CR>', opts)
			buf_set_keymap('n', '[d', '<Cmd>lua vim.diagnostic.goto_next()<CR>', opts)
			buf_set_keymap('n', ']d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
			buf_set_keymap('n', '<leader>vca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
			buf_set_keymap('n', '<leader>vrr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
			buf_set_keymap('n', '<leader>vrn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
			buf_set_keymap('i', '<C-h>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
		end
	})
end

-- Setup CMP (Completion)
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
		['<C-Space>'] = cmp.mapping.complete(),
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'ultisnips' },
	},
})

-- LSP diagnostics configuration
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
}
)

-- Set sign icons
vim.fn.sign_define('LspDiagnosticsSignError', { text = 'E', texthl = 'LspDiagnosticsSignError' })
vim.fn.sign_define('LspDiagnosticsSignWarning', { text = 'W', texthl = 'LspDiagnosticsSignWarning' })
vim.fn.sign_define('LspDiagnosticsSignHint', { text = 'H', texthl = 'LspDiagnosticsSignHint' })
vim.fn.sign_define('LspDiagnosticsSignInformation', { text = 'I', texthl = 'LspDiagnosticsSignInformation' })

-- LSP Zero setup
lsp_zero.on_attach(function(client, bufnr)
	lsp_zero.default_keymaps({ buffer = bufnr })
end)

-- Mason and Mason-lspconfig setup
require('mason').setup({})
require('mason-lspconfig').setup({
	-- Replace the language servers listed here
	-- with the ones you want to install
	ensure_installed = { 'tsserver', 'rust_analyzer' },
	handlers = {
		lsp_zero.default_setup,
	},
})

