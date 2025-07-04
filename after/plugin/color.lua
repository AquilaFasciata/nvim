function SetMyColors(color)
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "BlameLineNvim", { bg = "none" })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
	vim.api.nvim_set_hl(0, "LineNr", { fg = "#ffff00" })
	vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#77a1dc" })
	vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#77a1dc" })
end

SetMyColors("tokyodark")
