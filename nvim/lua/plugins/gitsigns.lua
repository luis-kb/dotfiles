local utils = require("core/utils")
local nmap = utils.nmap
local vmap = utils.vmap

return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add          = { text = '+' },
      change       = { text = '~' },
      delete       = { text = '-' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '#' },
    },
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 250,
      ignore_whitespace = false,
    },
    -- _signs_staged_enable = true,
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local opts = { buffer = bufnr }

      -- Navigation
      nmap(']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, vim.tbl_extend('force', opts, { expr = true }))

      nmap('[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, vim.tbl_extend('force', opts, { expr = true }))

      -- Actions
      nmap('<leader>gsh', gs.stage_hunk, opts)
      nmap('<leader>grh', gs.reset_hunk, opts)
      vmap('<leader>gsh',
        function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, opts)
      vmap('<leader>grh',
        function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, opts)
      nmap('<leader>gsb', gs.stage_buffer, opts)
      nmap('<leader>guh', gs.undo_stage_hunk, opts)
      nmap('<leader>grb', gs.reset_buffer, opts)
      nmap('<leader>gph', gs.preview_hunk, opts)
      nmap('<leader>gbl', function() gs.blame_line { full = true } end, opts)
      nmap('<leader>gtb', gs.toggle_current_line_blame, opts)
      nmap('<leader>gd', gs.diffthis, opts)
      nmap('<leader>gD', function() gs.diffthis('~') end, opts)
      nmap('<leader>gtd', gs.toggle_deleted, opts)

      -- Text object
      vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', opts)
    end
  }
}
