return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp'
    },
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      local servers = {
        "lua_ls",
        "tsserver",
        "eslint"
      }

      local onAttach = {
        eslint = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end
      }

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          on_attach = function(client, bufnr)
            local oa = onAttach[lsp];
            if oa then oa(client, bufnr) end
          end,
          capabilities = capabilities,
        }
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach-keymaps", { clear = true }),
        callback = function(event)
          require("config.keymaps").setup_lsp_keymaps(event)
        end,
      })
    end,
  },
}
