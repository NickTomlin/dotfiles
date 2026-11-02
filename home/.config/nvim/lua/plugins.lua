local catppuccin_flavour = "macchiato"

return {
  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = catppuccin_flavour,
      integrations = {
        treesitter = true,
        nvimtree = true,
        cmp = true,
        gitsigns = true,
        native_lsp = { enabled = true },
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-" .. catppuccin_flavour)
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
    opts = {
      options = {
        theme = "catppuccin-" .. catppuccin_flavour,
        component_separators = "|",
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        sorting_strategy = "ascending",
        layout_config = { prompt_position = "top" },
      },
    },
  },

  -- File tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      filters = { dotfiles = false },
      git = { enable = true },
    },
  },

  -- Surround (ysiw", cs"', ds", etc. — same bindings as vim-surround)
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = true,
  },

  -- Unix file commands: :Rename, :Move, :Delete, :Chmod, :SudoWrite
  "tpope/vim-eunuch",

  -- Git
  "tpope/vim-fugitive",

  -- Treesitter: better syntax highlighting and indentation
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter").install({
        "lua", "vim", "vimdoc",
        "javascript", "typescript", "tsx",
        "html", "css", "json", "markdown",
        "bash", "python",
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "lua", "vim", "help", "javascript", "javascriptreact",
          "typescript", "typescriptreact", "html", "css", "json",
          "markdown", "sh", "python",
        },
        callback = function(args)
          if pcall(vim.treesitter.start, args.buf) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
