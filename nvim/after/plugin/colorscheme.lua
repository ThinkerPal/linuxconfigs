function Colorup(color)
	color = color or "duskfox"

	vim.cmd.colorscheme(color)
	-- set the following when your terminal is the same theme
	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

end

Colorup()
