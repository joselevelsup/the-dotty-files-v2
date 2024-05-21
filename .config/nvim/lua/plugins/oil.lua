local function oilSplit(split)
  vim.cmd(split)
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_win_set_buf(win, buf)
  require("oil").open()
end

return {
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    event = { "VimEnter */*,.*", "BufNew */*,.*" },
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
    },
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["<Leader>e"] = {
                desc = "Get Lathered In Oil",
              },
              ["<Leader>ee"] = {
                function() require("oil").open() end,
                desc = "Get Lathered In Oil",
              },
              ["<Leader>ev"] = {
                function() oilSplit "vsplit" end,
                desc = "Get Vertical Oil-ly",
              },
              ["<Leader>es"] = {
                function() oilSplit "split" end,
                desc = "Get Horizontally Oil-ly",
              },
              ["<Leader>ef"] = {
                function() require("oil").open_float(nil) end,
                desc = "Get Horizontally Oil-ly",
              },
            },
          },
        },
      },
    },
  },
}
