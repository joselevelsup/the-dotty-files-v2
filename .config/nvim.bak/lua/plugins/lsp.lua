local M = {
  'neovim/nvim-lspconfig',
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp"
    },
    {
      "nvimdev/guard.nvim",
      dependencies = {
        "nvimdev/guard-collection",
      },
    },
    "ray-x/lsp_signature.nvim",
    {
      "rmagatti/goto-preview",
      config = true
    }
  },
  event = "BufReadPre"
}

function M.config()
  local cmp = require('cmp')
  local keymapper = require("utils").keymapper
  local custom_icons = require("custom-icons")

  local icons = {
    Text = custom_icons.kinds.Text,
    Method = custom_icons.kinds.Method,
    Function = custom_icons.kinds.Function,
    Constructor = custom_icons.kinds.Constructor,
    Field = custom_icons.kinds.Field,
    Variable = custom_icons.kinds.Variable,
    Class = custom_icons.kinds.Class,
    Interface = custom_icons.kinds.Interface,
    Module = custom_icons.kinds.Module,
    Property = custom_icons.kinds.Property,
    Unit = custom_icons.kinds.Unit,
    Value = custom_icons.kinds.Value,
    Enum = custom_icons.kinds.Enum,
    Keyword = custom_icons.kinds.Keyword,
    Snippet = custom_icons.kinds.Snippet,
    Color = custom_icons.kinds.Color,
    File = custom_icons.kinds.File,
    Reference = custom_icons.kinds.Reference,
    Folder = custom_icons.kinds.Folder,
    EnumMember = custom_icons.kinds.EnumMember,
    Constant = custom_icons.kinds.Constant,
    Struct = custom_icons.kinds.Struct,
    Event = custom_icons.kinds.Event,
    Operator = custom_icons.kinds.Operator,
    TypeParameter = custom_icons.kinds.TypeParameter,
  }

  cmp.setup({
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    formatting = {
      format = function(entry, vim_item)
        vim_item.kind = string.format(
          "%s %s",
          icons[vim_item.kind],
          vim_item.kind
        )

        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          luasnip = "[SNIP]",
          buffer = "[BUF]",
        })[entry.source.name]

        return vim_item
      end,
    },
    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
        { name = 'buffer' },
        { name = "path" }
      })
  })

  local function setup_diags()
    local signs = {
      { name = "DiagnosticSignError", text = "" },
      { name = "DiagnosticSignWarn", text = "" },
      { name = "DiagnosticSignHint", text = "" },
      { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
      -- disable virtual text
      virtual_text = true,
      -- show signs
      signs = {
        active = signs,
      },
      update_in_insert = true,
      underline = true,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded",
    })
  end


  local installedLSPs = {
    "lua_ls",
    "gopls",
    "templ",
    "svelte",
    "tsserver",
    "dockerls",
    "prismals",
    "rust_analyzer",
  }

  require("mason").setup();

  require("mason-lspconfig").setup({
    ensure_installed = installedLSPs,
  })

  local lspServers = require("lspconfig")

  local function onAttach(client, bufnr)
    local opts = { noremap = true, silent = true }

    local keymap = {
      { mode = "n", stroke = "gD", cmd = "lua vim.lsp.buf.declaration()" },
      { mode = "n", stroke = "gd", cmd = "lua vim.lsp.buf.definition()" },
      { mode = "n", stroke = "gpd", cmd = "lua require('goto-preview').goto_preview_definition()" },
      { mode = "n", stroke = "gpi", cmd = "lua require('goto-preview').goto_preview_implementation()" },
      { mode = "n", stroke = "gpr", cmd = "lua require('goto-preview').goto_preview_references()" },
      { mode = "n", stroke = "gl", cmd = 'lua vim.diagnostic.open_float(0, { scope = "line", border = "single" })' },
      { mode = "n", stroke = "K", cmd = "lua vim.lsp.buf.hover()" },
      { mode = "n", stroke = "<C-k>", cmd = "lua vim.lsp.buf.code_action()" },
      { mode = "n", stroke = "[d", cmd = 'lua vim.diagnostic.goto_prev({ border = "rounded" })' },
      { mode = "n", stroke = "]d", cmd = 'lua vim.diagnostic.goto_next({ border = "rounded" })' },
      { mode = "n", stroke = "<Leader>q", cmd = "lua vim.diagnostic.setloclist()" }
    }

    setup_diags()

    keymapper(keymap, opts, bufnr);
  end

  local local_capabilities = vim.lsp.protocol.make_client_capabilities()
  local cmp_lsp = require('cmp_nvim_lsp')

  lspServers.gleam.setup({
    on_attach = onAttach,
    capabilities = cmp_lsp.default_capabilities(local_capabilities),
    single_file_support = true
  })

  for _, lsp in ipairs(installedLSPs) do
    lspServers[lsp].setup({
      on_attach = onAttach,
      capabilities = cmp_lsp.default_capabilities(local_capabilities),
      single_file_support = true
    })
  end

  local ft = require('guard.filetype')

  ft('typescript,javascript,typescriptreact'):fmt('prettier')
  ft("go"):fmt("gofmt")

  require('guard').setup({
    fmt_on_save = true,
    lsp_as_default_formatter = false,
  })

end

return M
