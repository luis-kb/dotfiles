local utils = require('core.utils')
local nmap = utils.nmap
local vmap = utils.vmap
local common_opts = {noremap = true, silent = true}

-- Cancel highlights
nmap('<CR>', ':nohl<CR>', common_opts);

-- Splitting buffers
nmap('<leader>v', '<C-w>v', common_opts)
nmap('<leader>s', '<C-w>s', common_opts)
-- Opening as tab
nmap('<leader>T', '<C-w>T', common_opts)

-- Motions
-- =======

-- Moving between splits
nmap('<leader>h', '<C-w>h', common_opts)
nmap('<leader>j', '<C-w>j', common_opts)
nmap('<leader>k', '<C-w>k', common_opts)
nmap('<leader>l', '<C-w>l', common_opts)


-- Clipboard
-- =========

-- Copy to clipboard
nmap('<leader>y', '"+y', common_opts)
vmap('<leader>y', '"+y', common_opts)

-- Remaps
-- ======
nmap('<leader>jc', ':cle<CR>', common_opts)  -- Clear jump list
