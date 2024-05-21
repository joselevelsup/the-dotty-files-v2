return {
  "tpope/vim-fugitive",
  {
    "windwp/nvim-autopairs",
    config = true,
    event = "BufReadPost"
  },
  {
   'stevearc/oil.nvim',
    config = true
  },
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    config = function()
      require("illuminate").configure({ delay = 200 })
    end
  },
  {
    "kylechui/nvim-surround",
    config = true,
    event = "BufReadPost"
  },
  {
    'numToStr/Comment.nvim',
    config = true,
    event = "BufReadPost"
  },
  {
    'mrjones2014/smart-splits.nvim',
    event = "BufRead"
  },
  {
    "alvan/vim-closetag",
    ft = "html,jsx,ts,tsx"
  },
  'editorconfig/editorconfig-vim',
	"lukas-reineke/indent-blankline.nvim",
  {
    "coffebar/neovim-project",
    opts = {
      projects = { -- define project roots
        "~/Documents/personal/*",
        "~/Documents/work/tkh/*",
        "~/Documents/work/periodikal"
      },
    },
    init = function()
      -- enable saving the state of plugins in the session
      vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
      { "Shatur/neovim-session-manager" },
    },
    lazy = false,
  },
  {
    "declancm/maximize.nvim",
    config = true,
    event = "BufReadPost"
  },
  {
    "yorickpeterse/nvim-window",
    config = true,
  }
}

