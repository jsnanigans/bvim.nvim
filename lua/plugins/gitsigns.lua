return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {
      on_attach = function(bufnr)
        require('config.keymaps').setup_gitsigns_keymaps(bufnr)
      end,
    },
    config = function(_, opts)
      require('gitsigns').setup(opts)
    end,
  },
  -- { -- Adds git related signs to the gutter, as well as utilities for managing changes
  --   'lewis6991/gitsigns.nvim',
  --   opts = {
  --     signs = {
  --       add = { text = '+' },
  --       change = { text = '~' },
  --       delete = { text = '_' },
  --       topdelete = { text = '‾' },
  --       changedelete = { text = '~' },
  --     },
  --   },
  -- },
}
