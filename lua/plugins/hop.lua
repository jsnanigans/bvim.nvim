return {
  {
    'smoka7/hop.nvim',
    version = '*',
    config = function()
      require('hop').setup {
        keys = 'etovxqpdygfblzhckisuran',
      }
      require('config.keymaps').setup_hop_keymaps()
    end,
  },
}
