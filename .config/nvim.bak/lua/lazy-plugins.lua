local fn = vim.fn
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("plugins", {
  checker = {
    enabled = true
  },
  install = {
    colorscheme = {
      "monokai-pro",
      "tokyonight",
      "kanagawa",
    }
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
        "netrwPlugin",
        "tutor"
      }
    }
  }
})
