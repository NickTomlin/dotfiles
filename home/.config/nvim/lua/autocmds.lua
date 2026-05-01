local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Ensure backup/undo dirs exist
vim.fn.mkdir(vim.fn.expand("~/.nvimbackup"), "p")
vim.fn.mkdir(vim.fn.expand("~/.nvimundo"), "p")

-- Equalize splits on window resize
autocmd("VimResized", {
  group = augroup("resize_splits", { clear = true }),
  callback = function() vim.cmd("wincmd =") end,
})

-- Restore cursor position between sessions
autocmd("BufWinEnter", {
  group = augroup("restore_cursor", { clear = true }),
  callback = function()
    if vim.bo.filetype == "netrw" then return end
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.cmd('normal! g`"')
    end
  end,
})

-- Strip trailing whitespace on save
autocmd("BufWritePre", {
  group = augroup("strip_whitespace", { clear = true }),
  pattern = { "*.lua", "*.js", "*.ts", "*.jsx", "*.tsx", "*.css", "*.html", "*.py", "*.md" },
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

-- Reload config on save
autocmd("BufWritePost", {
  group = augroup("reload_vimrc", { clear = true }),
  pattern = vim.fn.expand("~/.config/nvim/init.lua"),
  callback = function() vim.cmd("source $MYVIMRC") end,
})
