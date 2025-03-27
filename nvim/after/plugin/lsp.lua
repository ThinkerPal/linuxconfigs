local lsp = require('lsp-zero').preset({})

require('mason-lspconfig').setup {
	ensure_installed = {
		'ts_ls',
		'eslint',
		'rust_analyzer',
		'lua_ls',
		'clangd',
		'pyright',
		'vimls'
	}
}
lsp.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp.default_keymaps({buffer = bufnr})
end)

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-Space>"] = cmp.mapping.complete(),
	["<C-Enter>"] = cmp.mapping.confirm({select=true}),
})
cmp.setup({
	mapping = cmp_mappings
})
-- (Optional) Configure lua language server for neovim
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
lspconfig.eslint.setup{}
lspconfig.rust_analyzer.setup{}
lspconfig.pyright.setup{}
lspconfig.clangd.setup{}

lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap=false}
	vim.keymap.set("n", "gd", function () vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
end)


lsp.setup()
