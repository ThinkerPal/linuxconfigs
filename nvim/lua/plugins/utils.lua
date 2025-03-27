return({
	{
		-- 'nvim-telescope/telescope.nvim', tag = '0.1.8',
		'nvim-telescope/telescope.nvim', branch = 'master', 
		-- or                              , branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},{
		"nvim-treesitter/nvim-treesitter", 
		"nvim-treesitter/playground", 
		build = ":TSUpdate"
	},
	"mbbill/undotree", 
	"tpope/vim-fugitive"
})
