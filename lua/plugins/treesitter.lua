return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed={'lua','vim','vimdoc','typescript','markdown','markdown_inline'},
        highlight = {
        enable= true
        }
      })
    end,
  },

  --{
  --  "nvim-treesitter/nvim-treesitter-context",
  --  event = "VeryLazy",
  --  dependencies = { "nvim-treesitter/nvim-treesitter", lazy = true },
  --},
}
