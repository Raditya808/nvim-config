-- lua/keymaps.lua

-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- =============================================================================
-- NAVIGATION & GENERAL
-- =============================================================================

-- Navigasi Window
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Simpan & Keluar
keymap("n", "<C-S>", ":wa<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>x", ":xa<CR>", opts)
keymap("n", "<leader>sc", ":nohlsearch<cr>", opts)

-- Editing
keymap("n", "<leader>a", "ggVG", opts) -- Select all
keymap("i", "kj", "<Esc>", opts)       -- Keluar insert mode cepat
keymap("n", ";", ":", { noremap = true, silent = false })

-- Split Window
keymap("n", "<leader>sv", "<C-w>v", opts)
keymap("n", "<leader>sh", "<C-w>s", opts)

-- =============================================================================
-- BUFFERLINE (Navigasi Tab File)
-- =============================================================================
keymap("n", "<TAB>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-TAB>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<leader>bc", ":BufferLinePickClose<CR>", opts)
keymap("n", "<leader>cb", ":bd<CR>", opts)

-- =============================================================================
-- TOGGLETERM (MENGGUNAKAN CTRL + T)
-- =============================================================================

-- Fungsi ini memastikan ToggleTerm terbuka di mode apapun
local function toggle_terminal()
    vim.cmd("ToggleTerm")
end

-- 1. Mode Normal: Buka terminal dengan Ctrl + t
vim.keymap.set('n', '<C-t>', toggle_terminal, opts)

-- 2. Mode Insert: Buka terminal saat sedang mengetik dengan Ctrl + t
vim.keymap.set('i', '<C-t>', function()
    vim.cmd("stopinsert")
    toggle_terminal()
end, opts)

-- 3. Mode Terminal: TUTUP terminal dengan Ctrl + t
vim.keymap.set('t', '<C-t>', [[<C-\><C-n><cmd>ToggleTerm<CR>]], opts)

-- Navigasi cepat untuk masuk ke Normal Mode di dalam terminal (tanpa menutup)
keymap("t", "kj", [[<C-\><C-n>]], opts)
keymap("t", "<Esc>", [[<C-\><C-n>]], opts)

-- =============================================================================
-- PLUGIN LAIN (Telescope, Neotree, Git)
-- =============================================================================
keymap("n", "<leader>e", ":Neotree reveal<CR>", opts)
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>lg", ":LazyGit<CR>", opts)

-- =============================================================================
-- DASHBOARD TOGGLE (OPTIMASI RAM)
-- =============================================================================
_G.toggle_dashboard = function()
    local ft = vim.bo.filetype
    local dashboard_fts = { "snacks_dashboard", "dashboard", "alpha", "starter" }
    
    -- Cek apakah buffer saat ini adalah dashboard
    local is_dashboard = false
    for _, dash_ft in ipairs(dashboard_fts) do
        if ft == dash_ft then
            is_dashboard = true
            break
        end
    end

    if is_dashboard then
        -- Pake bwipeout! buat paksa hapus buffer dari RAM
        vim.cmd("bwipeout!")
    else
        -- Buka dashboard berdasarkan plugin yang lu punya
        if pcall(require, "snacks") then
            require("snacks").dashboard.open()
        elseif pcall(require, "alpha") then
            vim.cmd("Alpha")
        else
            -- Backup ke command Dashboard biasa
            local status, err = pcall(vim.cmd, "Dashboard")
            if not status then
                print("Dashboard plugin tidak ditemukan")
            end
        end
    end
end
keymap("n", "<leader>h", "<cmd>lua toggle_dashboard()<CR>", opts)

-- =============================================================================
-- AUTOCMDS
-- =============================================================================
-- Esc di LazyGit langsung tutup dan bersihkan memori
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lazygit",
  callback = function()
    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>:q!<CR>", { buffer = true, silent = true })
  end,
})


--- =============================================================================
-- keymaps update part 24 for redo and undo 
--- =============================================================================

-- for undo 
keymap("n", "<C-z>","u",opts)

-- for redo 
keymap("n","<C-y>","<C-r>",opts)
