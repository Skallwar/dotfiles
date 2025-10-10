require "nvchad.mappings"

local map = vim.keymap.set
local unmap = vim.keymap.del

-- Unmap unused mappings
unmap("n", "<leader>e")
unmap("n", "<C-n>")
unmap("n", "<A-i>")
unmap("n", "<A-h>")
unmap("n", "<A-v>")
unmap("n", "<leader>h") -- Horizontal term
unmap("n", "<leader>v") -- Vertical term

-- NvimTree
map("n", "<leader>fe", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle NvimTree",  })

-- NvTerm
map("t", "<ESC>", "<C-\\><C-N>", { desc = "Exit terminal insert mode" })
map("n", "<leader>tf", function() require("nvchad.term").toggle { pos = "float", id = "floatTerm" } end, { desc = "Toggle floating term" })
map("n", "<leader>th", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })

map("n", "<leader>tv", function()
  require("nvchad.term").new { pos = "vsp" }
end, { desc = "terminal new vertical term" })

