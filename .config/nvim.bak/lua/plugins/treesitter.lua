return {
  {
    'nvim-treesitter/nvim-treesitter',
    cmd = "TSUpdate",
    event = "BufRead",
    config = function()

      vim.filetype.add({
        extension = {
          templ = "templ"
        }
      })

      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "vim",
          "regex",
          "bash",
          "css",
          "dockerfile",
          "go",
          "gomod",
          "graphql",
          "javascript",
          "json",
          "jsonc",
          "lua",
          "typescript",
          "templ",
          "norg",
          "org",
          "svelte",
          "tsx",
          "prisma",
          "v"
        },
        sync_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false
        },
        indent = {
          enable = true
        }
      })
    end
  },
}

