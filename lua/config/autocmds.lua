-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- refresh neovim whenever files change
local autocmd_group = vim.api.nvim_create_augroup("MyAutoCmds", { clear = true })

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  group = autocmd_group,
  pattern = "*",
  callback = function()
    vim.cmd("checktime")
  end,
  desc = "Refresh files when changed outside Neovim",
})

-- auto equalize window sizes
vim.api.nvim_create_autocmd("VimResized", {
  group = autocmd_group,
  pattern = "*",
  command = "tabdo wincmd =",
  desc = "Equalize window sizes",
})
