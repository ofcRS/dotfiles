set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

set autochdir
set clipboard=unnamedplus
set cursorline
set relativenumber

" Use Option+f then h to move to the window on the left
nnoremap <A-f>h <C-w>h

" Use Option+f then j to move to the window below
nnoremap <A-f>j <C-w>j

" Use Option+f then k to move to the window above
nnoremap <A-f>k <C-w>k

" Use Option+f then l to move to the window on the right
nnoremap <A-f>l <C-w>l

nnoremap <A-f>p :MRU<CR>

" My own mapping
nnoremap <A-f>n :tabn<CR>
nnoremap <A-f>b :tabp<CR>
nnoremap <A-f>w :tabc<CR>
inoremap <A-Space> <C-x><C-f>
nnoremap <A-f><F1> :NvimTreeToggle<CR>

inoremap jk <Esc>



call plug#begin() 
  Plug 'lervag/vimtex'
  Plug 'williamboman/mason.nvim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'}
  Plug 'saadparwaiz1/cmp_luasnip'
  " Plug 'jiangmiao/auto-pairs'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}
  Plug 'tpope/vim-surround'
  Plug 'hashivim/vim-terraform'
  Plug 'yegappan/mru'
  Plug 'voldikss/vim-floaterm'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'github/copilot.vim'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'scottmckendry/cyberdream.nvim'
call plug#end()

lua << EOF
    require('init')
EOF

