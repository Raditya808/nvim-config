return {
  -- telescope
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- catppuccin
  { "catppuccin/nvim", name = "catppuccin", priority = 1000, lazy = false },

  -- rosepine
  { "rose-pine/neovim", name = "rose-pine", lazy = false, enabled = false },

  -- tokyonight
  { "folke/tokyonight.nvim", enabled = false },

  -- toggleterm
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("plugins.configs.toggleterm_conf")
    end,
  },

  -- cord.nvim
  { "vyfor/cord.nvim", build = ":Cord update" },

  -- tmux navigator
  {
    "christoomey/vim-tmux-navigator",
    event = "BufReadPost",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  -- comment
  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    opts = require("plugins.configs.comment_conf"),
  },
  { "folke/todo-comments.nvim", enabled = false },
  -- renamer
  -- { "filipdutescu/renamer.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
}
