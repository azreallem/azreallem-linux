set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" https://github.com/plasticboy/vim-markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
call vundle#end()            " required
filetype plugin indent on    " required


" auto update configure of ~/.vimrc
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" enable fiee type detection
:filetype on
:filetype plugin on

syntax on
" set laststatus=2
set mouse=r
" set paste

" enable hightlight search
set hlsearch
" set cursorline
set autoindent

" theme
set background=dark

" others
set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936

" vim_markdown
let g:vim_markdown_folding_disabled = 1

" mapping
map <C-h> :browse oldfiles<CR>
inoremap <C-o> <Esc>o
