local function setup()
  local utils = require('core/utils')
  local nmap = utils.nmap

  nmap('<leader>tr', ':TroubleToggle<CR>', { noremap = true, silent = true })
end

return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = setup,
}
