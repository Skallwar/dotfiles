require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

local function set_language_config()
    local filetype = vim.bo.filetype

    if filetype == "gitcommit" then
        vim.wo.colorcolumn = '72'
    end

    if filetype == "rust" then
        vim.o.tabstop = 4
        vim.o.shiftwidth = 4
        vim.o.expandtab = true
    end
end

vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = {"*"},
  callback = function()
    set_language_config()
  end
})
