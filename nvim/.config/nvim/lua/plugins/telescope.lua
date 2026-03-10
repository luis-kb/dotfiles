local function setup()
  local builtin = require('telescope.builtin')
  local utils = require('core/utils')
  local nmap = utils.nmap

  nmap('<leader>ff', builtin.find_files, {})
  nmap('<leader>fg', builtin.live_grep, {})
  nmap('<leader>fb', builtin.buffers, {})
  nmap('<leader>fh', builtin.help_tags, {})
  nmap('<leader>gf', builtin.git_files, {})
  nmap('<leader>gb', builtin.git_branches, {})
  nmap('<leader>bf', builtin.current_buffer_fuzzy_find, {})
  nmap('<leader>jl', builtin.jumplist, {})
  nmap('<leader>fr', builtin.lsp_references, {})

  require('telescope').setup({
    -- defaults = vim.tbl_extend(
    --   'force',
    --   require('telescope.themes').get_dropdown({ winblend = 10 }),
    defaults = {
      mappings = {
        i = {
          -- map actions.which_key to <C-h> (default: <C-/>)
          -- actions.which_key shows the mappings for your picker,
          -- e.g. git_{create, delete, ...}_branch for the git_branches picker
          ['<C-h>'] = 'which_key'
        }
      }
    },
    pickers = {
      find_files = {
        find_command = { 'fd', '--no-ignore-vcs', '-t', 'file', '--hidden', '-E', '.git/',
          '-E', '__pycache__', '-E', 'node_modules/', '-E', '.venv/', '-E', '_build',
          '-E', 'deps', '-E', 'assets', '-E', '.elixir_ls', '-E', '.docs/', '-E',
          '.mypy_cache', '-E', '.pytest_cache', '-E', '.ruff_cache' },
      },
      git_files = {
        show_untracked = true,
      },
      live_grep = {
        glob_pattern = { '!__pycache__', '!node_modules/', '!.mypy_cache', '!pytest_cache',
          '!.ruff_cache', '!poetry.lock' },
      },
    },
    extensions = {
      -- Your extension configuration goes here:
      -- extension_name = {
      --   extension_config_key = value,
      -- }
      -- please take a look at the readme of the extension you want to configure
    }
  })
  require('telescope').load_extension('fzf')
end

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = setup
}
