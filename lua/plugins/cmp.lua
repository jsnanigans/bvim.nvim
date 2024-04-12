return {
  -- nvim-cmp configuration so to not preselect completion and require tab to select
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      {
        'hrsh7th/cmp-nvim-lsp',
        dependencies = {
          {
            'L3MON4D3/LuaSnip',
            dependencies = {
              'saadparwaiz1/cmp_luasnip',
              'rafamadriz/friendly-snippets',
            },
          },
        },
      },
    },
    opts = function()
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
      end

      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert {
          ['<CR>'] = vim.NIL,

          ['<C-y>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true }
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true }
            -- elseif require('copilot.suggestion').is_visible() then
            --   require('copilot.suggestion').accept()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<C-j>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<C-k>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<C-l>'] = cmp.mapping(function(fallback)
            if require('copilot.suggestion').is_visible() then
              cmp.close()
              require('copilot.suggestion').accept()
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        preselect = cmp.PreselectMode.None,
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'luasnip' },
          { name = 'buffer' },
          -- { name = 'emoji' },
          -- { name = 'nvim_lsp' },
          -- { name = 'vsnip' }, -- For vsnip users.
          -- { name = 'luasnip' }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
        }, {
          { name = 'buffer' },
        }),
      }
    end,
  },
}
