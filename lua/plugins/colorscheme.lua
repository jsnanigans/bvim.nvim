return {
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   init = function()
  --     -- TODO: set colorscheme based on system/terminal dark/light mode
  --     -- Also see utils/colorscheme.lua
  --     vim.cmd.colorscheme("tokyonight-moon")
  --   end,
  -- },
  --
  -- {
  --   "catppuccin/nvim",
  --   enabled = false,
  --   name = "catppuccin",
  -- },

  -- {
  --   "rose-pine/neovim",
  --   -- enabled = false,
  --   lazy=false,
  --   name = "rose-pine",
  --   init = function()
  --     -- TODO: set colorscheme based on system/terminal dark/light mode
  --     -- Also see utils/colorscheme.lua
  --     vim.cmd.colorscheme("rose-pine")
  --   end,
  -- },
   {
      "nyoom-engineering/oxocarbon.nvim",
      lazy=false,
      init = function()
        vim.cmd.colorscheme("oxocarbon")
      end,
    }
}
