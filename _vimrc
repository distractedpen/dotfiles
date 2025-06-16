"Building a personal vim experience
set nocompatible "be iMprovided, required
filetype off
set nobackup
set belloff=all
" set noeb vb t_vb=
" autocmd GUIEnter * set visualbell t_vb=
set exrc
set encoding=UTF-8
call plug#begin()

"====================Plugins go here======================
Plug 'vim-scripts/L9'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'garbas/vim-snipmate'
Plug 'MarcWeber/vim-addon-mw-utils'
"====================Plugins End here=====================

call plug#end()
silent! colorscheme gruvbox
set background=dark
set ruler
set mouse=a " set the value to c to disable
set relativenumber
set hidden
set number
set smartindent
set st=4 sw=4 et
set shiftwidth=4
set tabstop=4
set colorcolumn=120
set laststatus=2
set autoread
set backspace=indent,eol,start
let g:vim_json_syntax_conceal = 0

" Airline config
let g:airline_theme='gruvbox'


" Keymapping
let mapleader=','
nmap <leader>ff :CtrlP<CR>
nmap <leader>fb :CtrlPBuffer<CR>

nnoremap K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" GVim options

:set guioptions-=m
:set guioptions-=t
:set guioptions-=r
:set guioptions-=L
:set guioptions-=T
:set lines=999 columns=999
let &guifont='0xProto Nerd Font Mono:h12'

