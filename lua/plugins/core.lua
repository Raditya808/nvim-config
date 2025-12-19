return {
  -- add typescript
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- blink-cmp
  {
    "Saghen/blink.cmp",
    dependencies = {
      "onsails/lspkind.nvim",
    },
    config = function()
      require("plugins.configs.blinkcmp_conf")
    end,
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  -- neotree file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    opts = require("plugins.configs.neotree"),
  },

  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },

  -- disable flash nvim
  { "folke/flash.nvim", enabled = false },

  -- add any tools you want to have installed below
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "html-lsp",
        "css-lsp",
        "stylua",
        "prettier",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },

  -- which key
  { "folke/which-key.nvim", enabled = false },

  -- todo-comments
  { "folke/todo-comments.nvim", enabled = false }, -- disable
}
