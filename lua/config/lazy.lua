-- 1. Bootstrapping Lazy.nvim (Download otomatis jika belum ada)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo(
      { { "Failed to clone lazy.nvim:\n", "ErrorMsg" }, { out, "WarningMsg" }, { "\nPress any key to exit..." } },
      true,
      {}
    )
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- 2. Konfigurasi Utama Lazy.nvim
require("lazy").setup({
  spec = {
    -- Import sistem utama LazyVim
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- Plugin GitHub Copilot (Base)
    { "github/copilot.vim" },

    -- Plugin Copilot Chat (Tambahan yang kamu minta gabung)
    {
      "CopilotC-Nvim/CopilotChat.nvim",
      dependencies = {
        { "nvim-lua/plenary.nvim", branch = "master" },
      },
      build = "make tiktoken",
      opts = {
        -- Kamu bisa isi konfigurasi chat di sini
        debug = false,
      },
    },

    -- Import folder 'plugins' pribadi kamu (jika ada file di lua/plugins/*.lua)
    { import = "plugins" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  checker = { enabled = true, notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
