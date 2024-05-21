-- don't do anything in non-vscode instances
if not vim.g.vscode then return {} end

-- a list of known working plugins with vscode-neovim, update with your own plugins
local plugins = {
  "lazy.nvim",
  "AstroNvim",
  "astrocore",
  "astroui",
  "Comment.nvim",
  "nvim-autopairs",
  "nvim-treesitter",
  "nvim-ts-autotag",
  "nvim-treesitter-textobjects",
  "nvim-ts-context-commentstring",
}

local Config = require "lazy.core.config"
-- disable plugin update checking
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
-- replace the default `cond`
Config.options.defaults.cond = function(plugin) return vim.tbl_contains(plugins, plugin.name) end

local nvscode = require "vscode-neovim"

--I honestly don't care if this looks shitty. This is just for vscode when I gotta use it.
---@type LazySpec
return {
  -- add a few keybindings
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader><Leader>"] = function() nvscode.call "workbench.action.showCommands" end,
          ["<Leader>ff"] = function() nvscode.call "workbench.action.quickOpen" end,
          ["<Leader>ee"] = function() nvscode.call "file-browser.open" end,
          ["<Leader>ef"] = function() nvscode.call "workbench.explorer.fileView.focus" end,
          ["<Leader>bb"] = function() nvscode.call "workbench.action.showAllEditors" end,
          ["<Leader>bd"] = function() nvscode.call "workbench.action.closeActiveEditor" end,
          ["<Leader>gg"] = function() nvscode.call "magit.status" end,
          ["<Leader>th"] = function() nvscode.call "workbench.view.extension.thunder-client" end,
          ["<Leader>n"] = function() nvscode.call "workbench.action.files.newUntitledFile" end,
          ["<Leader>wsh"] = function()
            nvscode.call "workbench.action.splitEditorLeft"
            nvscode.call "file-browser.open"
          end,
          ["<Leader>wsl"] = function()
            nvscode.call "workbench.action.splitEditorRight"
            nvscode.call "file-browser.open"
          end,
          ["<Leader>wsj"] = function()
            nvscode.call "workbench.action.splitEditorDown"
            nvscode.call "file-browser.open"
          end,
          ["<Leader>wsk"] = function()
            nvscode.call "workbench.action.splitEditorUp"
            nvscode.call "file-browser.open"
          end,
          ["<Leader>wh"] = function() nvscode.call "workbench.action.navigateLeft" end,
          ["<Leader>wl"] = function() nvscode.call "workbench.action.navigateRight" end,
          ["<Leader>wj"] = function() nvscode.call "workbench.action.navigateDown" end,
          ["<Leader>wk"] = function() nvscode.call "workbench.action.navigateUp" end,
          ["<Leader>pp"] = function() nvscode.call "workbench.action.openRecent" end,
          ["<Leader>pd"] = function() nvscode.call "workbench.action.closeFolder" end,
        },
      },
    },
  },
  -- disable colorscheme setting
  { "AstroNvim/astroui", opts = { colorscheme = false } },
  -- disable treesitter highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { highlight = { enable = false } },
  },
}
