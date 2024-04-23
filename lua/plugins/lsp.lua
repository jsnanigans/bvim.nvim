return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'hrsh7th/cmp-nvim-lsp'
    },
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      local servers = {
          "lua_ls",
          "tsserver"
      }

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          -- on_attach = my_custom_on_attach,
          capabilities = capabilities,
        }
      end
    end,
  },
}
