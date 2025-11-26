require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

local function set_language_config()
    local filetype = vim.bo.filetype

    if filetype == "gitcommit" then
        vim.wo.colorcolumn = '72'
    end
end

vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = {"*"},
  callback = function()
    set_language_config()
  end
})
