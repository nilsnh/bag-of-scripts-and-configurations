
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set mouse=v                 " middle-click paste with mouse
set hlsearch                " highlight search results
set tabstop=2               " number of columns occupied by a tab character
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=2            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a
colorscheme slate

" Source: https://stackoverflow.com/a/446293
let mapleader=" "
nnoremap <SPACE> <Nop>

" SourceLocal loads relative files.
" see: https://stackoverflow.com/a/48828172
function! SourceLocal(relativePath)
  let root = expand('%:p:h')
  let fullPath = root . '/'. a:relativePath
  exec 'source ' . fullPath
endfunction

call plug#begin()
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
call plug#end()

lua << END
require'lualine'.setup{
  options = {
    theme = 'powerline_dark',
  }
}
require'nvim-tree'.setup()
local saga = require 'lspsaga'
saga.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  border_style = "round",
}
END

lua require('lspconfig')

" Reload config
nnoremap <leader>sv :source $MYVIMRC<CR> 

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" NvimTreeOpen, NvimTreeClose, NvimTreeFocus, NvimTreeFindFileToggle, and NvimTreeResize are also available if you need them
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue

nnoremap <silent>K :Lspsaga hover_doc<CR>

" Make an easy save
inoremap <c-s> <Esc>:w<CR>
nnoremap <c-s> :w<CR>















