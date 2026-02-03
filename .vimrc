" ============================================================================
" General Settings
" ============================================================================
set nocompatible              " be iMproved, required
filetype off                  " required

" ============================================================================
" Vundle Plugin Management
" ============================================================================
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'jmcantrell/vim-diffchanges'
Plugin 'airblade/vim-gitgutter'
Plugin 'antiagainst/vim-tablegen'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'Exafunction/codeium.vim'

call vundle#end()            " required
filetype plugin indent on    " required

" ============================================================================
" UI & Behavior
" ============================================================================
syntax on
set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gbk,cp936,gb2312,gb18030

set number                  " Show line numbers
set laststatus=2            " Always show status line
set mouse=a                 " Enable mouse support
set wildmenu                " Enhanced command line completion
set backspace=indent,eol,start " Fix backspace behavior

" Indentation
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" Search
set incsearch               " Incremental search
set hlsearch                " Highlight search results
set ignorecase              " Case insensitive search
set smartcase               " Case sensitive if capital used

" Files
set nobackup
set noswapfile
set noundofile
set autoread                " Auto read when file is changed from outside

" Clipboard
" Only use unnamedplus if we are in a local GUI or have a valid X connection.
" Otherwise, rely on our custom OSC 52 function.
if has('gui_running') || (!empty($DISPLAY) && executable('xclip'))
    set clipboard=unnamedplus
else
    set clipboard=
endif

" ============================================================================
" Theme
" ============================================================================
try
    colorscheme slate
catch
    colorscheme default
endtry

" Custom Highlights
highlight Normal ctermbg=0 ctermfg=244 guibg=#000000 guifg=#808080
highlight LineNr ctermfg=DarkGrey guifg=DarkGrey

" ============================================================================
" Plugin Configurations
" ============================================================================
" vim-markdown
let g:vim_markdown_folding_disabled = 1

" vim-gitgutter
set foldtext=gitgutter#fold#foldtext()
let g:gitgutter_use_location_list = 0
set updatetime=100

" ============================================================================
" Custom Functions
" ============================================================================

" Tab Navigation
function! TabLeft()
   if tabpagenr() == 1
      execute "tabm"
   else
      execute "tabm -1"
   endif
endfunction

function! TabRight()
   if tabpagenr() == tabpagenr('$')
      execute "tabm" 0
   else
      execute "tabm +1"
   endif
endfunction

" Git Diff
let file_path = expand('%:p')
function! GitDiff()
    :silent write
    :silent execute '!git diff'
    :redraw!
endfunction

" Cscope Reconnect
function! ReConnectCscope()
    exec "cs kill 0"
    exec "!cscope.sh"
    exec "cs add cscope.out"
endfunction

" Clipboard Integration (Delegated to external script)
function! CopyToTmuxAndSystem()
    let l:text = @0
    let l:script = expand('~/scripts/yank.sh')
    
    if executable(l:script)
        call system(l:script, l:text)
    endif
endfunction

" Auto copy on yank
augroup SystemClipboard
    autocmd!
    if exists("##TextYankPost")
        autocmd TextYankPost * if v:event.operator ==# 'y' | call CopyToTmuxAndSystem() | endif
    endif
augroup END

" ============================================================================
" Key Mappings
" ============================================================================
let mapleader = ","

" Tab Navigation
map <silent><C-j> :execute TabLeft()<CR>
map <silent><C-k> :execute TabRight()<CR>

" Function Keys
nmap <F1> :GitGutterQuickFix<cr>:copen<cr>
nmap <F2> :call GitDiff()<cr>
nmap <F3> :set tabstop=4<cr>:set shiftwidth=4<cr>:set expandtab<cr>
nmap <F4> :!cscope -Rbq<cr>:cs reset<cr>:call ReConnectCscope()<cr><cr><cr>

" Cscope
nmap cf :cscope help<cr>:cs find 
nmap tcf :cscope help<cr>:tab cs find 
nmap <leader>cs :cs find s 
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>

" GitGutter
nmap gj <Plug>(GitGutterNextHunk)
nmap gk <Plug>(GitGutterPrevHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)

" Codeium
imap <script><silent><nowait><expr> <Tab> codeium#Accept()
imap <C-;>   codeium#CycleCompletions(1)
imap <C-,>   codeium#CycleCompletions(-1)
imap <C-x>   codeium#Clear()

" Misc
noremap <leader>y :call CopyToTmuxAndSystem()<CR>
" =============================================================
