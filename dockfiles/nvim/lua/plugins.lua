require("mason").setup()

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'tsserver' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end


-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}



-- optionally enable 24-bit colour
vim.opt.termguicolors = true

local tree_api = require("nvim-tree.api")
local Event = tree_api.events.Event

tree_api.events.subscribe(Event.TreeOpen, function()
  tree_api.tree.focus()
  vim.cmd('set relativenumber')
end)

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 35,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})
 
require("user_fn")


require("tokyonight").setup({
    style = "moon",
    transparent = true,
    italic_comments = true,
    italic_keywords = true,
    italic_functions = true,
    italic_variables = false,
    dark_sidebar = true,
    dark_float = true,
    hide_inactive_statusline = true,
    sidebars = { "qf", "vista_kind", "terminal", "packer" },
    colors = {
        red = "#ff5370",
        green = "#c3e88d",
        yellow = "#ffcb6b",
        -- blue = "#82aaff",
        blue = "#82aaff",
        purple = "#c792ea",
        cyan = "#89ddff",
        orange = "#f78c6c",
        magenta = "#ff5370",
        bg_sidebar = "#1f2335",
        bg_statusline = "#1f2335",
        bg_float = "#1f2335",
    }, 
    on_colors = function(colors)
        colors.comment = colors.red
        colors.bg_visual = "#3e68d7"
    end
})


vim.cmd[[colorscheme tokyonight]]
vim.cmd[[highlight CursorLineNr guifg=#4fd6be]]
vim.cmd[[highlight LineNrAbove guifg=#c0caf5]]
vim.cmd[[highlight LineNrBelow guifg=#c0caf5]]

