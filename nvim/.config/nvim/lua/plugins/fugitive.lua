local function setup()
  local utils = require('core/utils')
  local nmap = utils.nmap

  nmap('<leader>Gd', ':G diff<CR>')
  nmap('<leader>Gds', ':G diff --staged<CR>')
  nmap('<leader>Ga.', ':G add .<CR>')
  nmap('<leader>Gc', ':G commit<CR>')
end

return {
  'tpope/vim-fugitive',
  config = setup, 
}
