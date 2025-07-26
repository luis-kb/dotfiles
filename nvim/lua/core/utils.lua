-- Core utilities to help in the creation of DRY configurations
--
-- Usage:
-- local utils = require('core/utils')
-- utils.nmap(...)
--
--

-- Default export
local M = {}


-- Keymapping
-- ==========

-- Set a keymap for normal mode.
-- @param lhs string: The left hand side of the mapping.
-- @param rhs string: The right hand side of the mapping.
-- @param opts table: The options for the mapping.
function M.nmap(lhs, rhs, opts)
  vim.keymap.set('n', lhs, rhs, opts)
end

function M.vmap(lhs, rhs, opts)
  vim.keymap.set('v', lhs, rhs, opts)
end

function M.imap(lhs, rhs, opts)
  vim.api.nvim_set_keymap('i', lhs, rhs, opts)
end

function M.xmap(lhs, rhs, opts)
  vim.api.nvim_set_keymap('x', lhs, rhs, opts)
end

-- ==========


return M
