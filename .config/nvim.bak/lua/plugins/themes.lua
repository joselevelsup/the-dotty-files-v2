return {
  'rebelot/kanagawa.nvim',
  "EdenEast/nightfox.nvim",
  {
    "catppuccin/nvim",
    name = "catppuccin",
  },
  {
    'dasupradyumna/midnight.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd('colorscheme midnight')
    end,
  },
}

