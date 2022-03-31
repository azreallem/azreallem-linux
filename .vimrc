set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" https://github.com/plasticboy/vim-markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'dense-analysis/ale'
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
" set background=dark

" others
set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936

" vim_markdown Plugin
let g:vim_markdown_folding_disabled = 1

" mapping
map <C-h> :browse oldfiles<CR>

" Shortcuts to move between tabs with Ctrl+h/j
function TabLeft()
   if tabpagenr() == 1
      execute "tabm"
   else
      execute "tabm -1"
   endif
endfunction

function TabRight()
   if tabpagenr() == tabpagenr('$')
      execute "tabm" 0
   else
      execute "tabm +1"
   endif
endfunction

map <silent><C-j> :execute TabRight()<CR>
map <silent><C-k> :execute TabLeft()<CR>
" ale Plugin
nmap <silent> <C-n> <Plug>(ale_next_wrap)
" 文件内容发生变化时不进行检查
" let g:ale_lint_on_text_changed = 'never'
" " " 打开文件时不进行检查
" let g:ale_lint_on_enter = 0
let g:ale_linters = {
\   'c++': ['g++'],
\   'c': ['gcc'],
\   'python': ['pylint'],
\}

