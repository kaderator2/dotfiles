vim.g.mapleader = " "
require("lazy-config")
require("chade.remap")
require("chade.set")
require("mason").setup()
require("mason-lspconfig").setup()
require("lspconfig")
