-- Open new horizontal split on top
vim.opt.splitbelow = false

-- Use ripgrep for :grep
vim.o.grepprg="rg --vimgrep"

-- vim.o.grepformat^='%f:%l:%c:%m'

vim.g.noswapfile = true

vim.g.exrc = true
vim.g.secure = true

vim.opt.list = true
vim.opt.listchars.trail = '·'
vim.opt.listchars.tab = '>·'
vim.opt.clipboard = "unnamedplus"

-- Indentation settings
vim.g.colorcolumn = 81
vim.g.sts = 0
vim.g.noexpandtab = true
vim.g.tabstop = 8
vim.g.softtabstop = 0
vim.g.c_syntax_for_h = true
vim.opt.iskeyword:remove('_')

vim.api.nvim_create_autocmd("FileType", {
	pattern = {"c", "cpp"},
	command = "setlocal colorcolumn=81 | setlocal noexpandtab ts=8 sw=8 sts=0",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "gitcommit",
	command = "setlocal colorcolumn=81",
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.overlay",
  command = "setfiletype devicetree"
})
