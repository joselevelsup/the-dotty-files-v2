local config = {
  g = {
    mapleader = ' ',
    indentLine_fileTypeExclude = { 'dashboard' },
    indentLine_setConceal = 0,
    mouse = "nvi",
    mousehide = true,
  },
  o = {
    termguicolors = true,
    cursorcolumn = true,
    cursorline = true,
    tabstop = 2,
    shiftwidth = 2,
    expandtab = true,
    clipboard = "unnamedplus",
    cmdheight = 0,
    guicursor = "i:block",
    splitbelow = true,
    splitright = true
  },
  go = {
    encoding = 'utf-8',
    hidden = true,
    background = 'dark',
    syntax = 'enable',
    history = 1000,
    completeopt = "menu,menuone,noselect",
    guifont = "JetBrainsMono Nerd Font:h9"
  },
  wo = {
    number = true,
    relativenumber = true
  }
}

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, { pattern = "*.v", command = "setfiletype vlang" });

vim.cmd('filetype plugin indent on')

for configKey, configValue in pairs(config) do
  for vimKey, vimValue in pairs(configValue) do
    vim[configKey][vimKey] = vimValue
  end
end

