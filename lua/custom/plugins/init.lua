-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    config = function()
      require('typescript-tools').setup {
        settings = {
          -- spawn additional tsserver instance to calculate diagnostics on it
          separate_diagnostic_server = true,
          -- "change"|"insert_leave" determine when the client asks the server about diagnostic
          publish_diagnostic_on = 'insert_leave',
          -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
          -- "remove_unused_imports"|"organize_imports") -- or string "all"
          -- to include all supported code actions
          -- specify commands exposed as code_actions
          expose_as_code_action = {},
          -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
          -- not exists then standard path resolution strategy is applied
          tsserver_path = nil,
          -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
          -- (see 💅 `styled-components` support section)
          tsserver_plugins = {
            -- for TypeScript v4.9+
            '@styled/typescript-styled-plugin',
            -- or for older TypeScript versions
            -- "typescript-styled-plugin",
          },
          -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
          -- memory limit in megabytes or "auto"(basically no limit)
          tsserver_max_memory = 'auto',
          -- described below
          tsserver_format_options = {},
          tsserver_file_preferences = {},
          -- locale of all tsserver messages, supported locales you can find here:
          -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
          tsserver_locale = 'en',
          -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
          complete_function_calls = false,
          include_completions_with_insert_text = true,
          -- CodeLens
          -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
          -- possible values: ("off"|"all"|"implementations_only"|"references_only")
          code_lens = 'off',
          -- by default code lenses are displayed on all referencable values and for some of you it can
          -- be too much this option reduce count of them by removing member references from lenses
          disable_member_code_lens = true,
          -- JSXCloseTag
          -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
          -- that maybe have a conflict if enable this feature. )
          jsx_close_tag = {
            enable = true,
            filetypes = { 'javascriptreact', 'typescriptreact' },
          },
        },
      }

      -- keymaps:
      -- TSToolsOrganizeImports - sorts and removes unused imports
      vim.keymap.set('n', '<leader>to', '<cmd>TSToolsOrganizeImports<cr>', { desc = '[O]rganize Imports' })
      -- TSToolsSortImports - sorts imports
      vim.keymap.set('n', '<leader>ts', '<cmd>TSToolsSortImports<cr>', { desc = '[S]ort Imports' })
      -- TSToolsRemoveUnusedImports - removes unused imports
      vim.keymap.set('n', '<leader>tI', '<cmd>TSToolsRemoveUnusedImports<cr>', { desc = 'Remove Unused [I]mports' })
      -- TSToolsRemoveUnused - removes all unused statements
      vim.keymap.set('n', '<leader>tu', '<cmd>TSToolsRemoveUnused<cr>', { desc = 'Remove [U]nused' })
      -- TSToolsAddMissingImports - adds imports for all statements that lack one and can be imported
      vim.keymap.set('n', '<leader>ti', '<cmd>TSToolsAddMissingImports<cr>', { desc = 'Add Missing [I]mports' })
      -- TSToolsFixAll - fixes all fixable errors
      vim.keymap.set('n', '<leader>tf', '<cmd>TSToolsFixAll<cr>', { desc = '[F]ix All' })
      -- TSToolsGoToSourceDefinition - goes to source definition (available since TS v4.7)
      vim.keymap.set('n', '<leader>td', '<cmd>TSToolsGoToSourceDefinition<cr>', { desc = 'Go to Source [D]efinition' })
      -- TSToolsRenameFile - allow to rename current file and apply changes to connected files
      vim.keymap.set('n', '<leader>tn', '<cmd>TSToolsRenameFile<cr>', { desc = 'Re[N]ame File' })
      -- TSToolsFileReferences - find files that reference the current file (available since TS v4.2)
      vim.keymap.set('n', '<leader>tr', '<cmd>TSToolsFileReferences<cr>', { desc = 'File [R]eferences' })
    end,
  },

  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        panel = {
          enabled = true,
        },
        suggestion = {
          enabled = false,
        },
      }

      vim.keymap.set('n', '<leader>cp', '<cmd>Copilot panel<cr>', { desc = 'Copilot Panel' })
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end,
  },
}
