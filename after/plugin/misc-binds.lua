vim.keymap.set("n", "<leader>lpm", vim.cmd.Lazy)
vim.keymap.set("n", "<leader>cc", vim.cmd.make)

vim.keymap.set("n", "<leader>fr", function()
	vim.cmd.set({ args = { 'foldlevel=99' } })
end, { desc = 'Reset fold level (Sets to 99)' })

vim.keymap.set("n", "<leader>ft", function()
	if FOLD_RESET_EXECUTED == nil then
		FOLD_RESET_EXECUTED = false
		FR_NEXTFOLD = -1
	end

	FR_LASTFOLD = vim.o.foldlevel

	if FOLD_RESET_EXECUTED then
		vim.o.foldlevel = FR_NEXTFOLD
	else
		vim.o.foldlevel = 99
		FOLD_RESET_EXECUTED = true
	end

	FR_NEXTFOLD = FR_LASTFOLD
end, { desc = 'Toggles foldlevel between 2 levels' })
