local map = vim.keymap.set

-- Disable ex mode
map("n", "Q", "<Nop>")

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Keep visual selection when indenting
map("n", ">", ">gv")
map("v", "<", "<gv")

-- Paste in visual mode without overwriting clipboard
map("x", "p", function()
  return 'pgv"' .. vim.v.register .. "y"
end, { expr = true })

-- Clear search highlights
map("n", "<leader>nh", "<cmd>noh<CR>", { silent = true })
map("n", "<Esc>", "<cmd>noh<CR>")

-- Save
map("n", "<C-s>", "<cmd>w<CR>")

-- Toggle semicolon at end of line
map("n", "<leader>;", function()
  local line = vim.api.nvim_get_current_line()
  if line:match(";$") then
    vim.api.nvim_set_current_line(line:sub(1, -2))
  else
    vim.api.nvim_set_current_line(line .. ";")
  end
end, { desc = "Toggle trailing semicolon" })

-- Insert mode: operator shortcuts carried over from old config
map("i", "<C-l>", " => ")
map("i", "<C-k>", " |> ")

-- Comment toggle (neovim 0.10+ built-in)
map("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment" })
map("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment" })

-- Vimrc shortcuts
map("n", "<leader>vv", "<cmd>vsp $MYVIMRC<CR>", { desc = "Open vimrc in vsplit" })
map("n", "<leader>vs", "<cmd>source $MYVIMRC<CR>", { desc = "Source vimrc" })

-- NvimTree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file tree" })

-- Telescope
map("n", "<leader>ff", function() require("telescope.builtin").find_files() end, { desc = "Find files" })
map("n", "<leader>fw", function() require("telescope.builtin").live_grep() end, { desc = "Live grep" })
map("n", "<leader>fg", function() require("telescope.builtin").git_files() end, { desc = "Git files" })
map("n", "<leader>fb", function() require("telescope.builtin").buffers() end, { desc = "Buffers" })
map("n", "<leader>fh", function() require("telescope.builtin").help_tags() end, { desc = "Help tags" })
map("n", "<leader>fo", function() require("telescope.builtin").oldfiles() end, { desc = "Recent files" })

-- Fugitive
map("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Git status" })
map("n", "<leader>gd", "<cmd>Gdiffsplit<CR>", { desc = "Git diff split" })
