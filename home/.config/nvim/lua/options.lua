local opt = vim.opt

-- Appearance
opt.number = true
opt.cursorline = true
opt.termguicolors = true
opt.scrolloff = 5
opt.showmode = false
opt.signcolumn = "yes"
opt.wrap = true
opt.linebreak = true
opt.list = false
opt.textwidth = 0
opt.wrapmargin = 0

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.autoindent = true
opt.smartindent = true
opt.shiftround = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.gdefault = true

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Files / history
opt.swapfile = false
opt.backup = true
opt.backupdir = vim.fn.expand("~/.nvimbackup//")
opt.undofile = true
opt.undodir = vim.fn.expand("~/.nvimundo")

-- Misc
opt.title = true
opt.mouse = ""
opt.spell = true
opt.exrc = true
opt.secure = true
opt.wildmenu = true
opt.wildmode = "longest:list"
opt.wildignore:append({ "*/tmp/*", "*.so", "*.swp", "*.zip", ".DS_STORE", "*.pyc", "node_modules" })

-- Don't clobber clipboard when pasting in visual mode (handled in keymaps)
-- Disable SQL omni-completion popup
vim.g.omni_sql_no_default_maps = 1
