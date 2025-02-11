set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'jmcantrell/vim-diffchanges'
Plugin 'airblade/vim-gitgutter'
Plugin 'antiagainst/vim-tablegen'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'ycm-core/YouCompleteMe'
call vundle#end()            " required
filetype plugin indent on    " required



"" auto update configure of ~/.vimrc
"autocmd BufWritePost $MYVIMRC source $MYVIMRC

" cscope file auto load
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=1
    set cst
    set nocsverb
    if filereadable("cscope.out")
            cs add cscope.out
    endif
    set csverb
endif

" enable fiee type detection
:filetype on
:filetype plugin on



" NORMAL ===>

syntax on
set laststatus=2
set mouse=a
set hlsearch
set autoindent
set nu
set wildmenu
set paste
set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gbk,cp936,gb2312,gb18030



" <=== NORMAL


" THEME ===>

colorscheme desert
set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40
"" Highlight cursor line underneath the cursor horizontally.
"highlight CursorLine cterm=NONE ctermbg=grey guibg=NONE guifg=NONE
"set cursorline
highlight MatchParen ctermfg=Red ctermbg=Yellow guifg=Red guibg=Yellow

" <=== THEME


" FUNCTIONS ===>

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

" Shortcuts to show gitdiff with F4
function GitDiff()
    :silent write
    :silent execute '!git diff --color=always -- ' . expand('%:p') . ' | less --RAW-CONTROL-CHARS'
    :redraw!
endfunction

func! ReConnectCscope()
	exec "cs kill 0"
	exec "!cscope.sh"
	exec "cs add cscope.out"
endfunc

" <=== FUNCTIONS


" PLUGIN ===>

" vim_markdown Plugin
let g:vim_markdown_folding_disabled = 1

" gitgutter Plugin
set foldtext=gitgutter#fold#foldtext()
let g:gitgutter_use_location_list = 0
set updatetime=100

" <=== PLUGIN


" MAPPING ===>

nmap cf :cscope help<cr>:cs find 
nmap tcf :cscope help<cr>:tab cs find 
nmap <F1> :GitGutterQuickFix<cr>:copen<cr>
nmap <F2> :call GitDiff()<cr>
nmap <F3> :set tabstop=4<cr>:set shiftwidth=4<cr>:set expandtab<cr>
nmap <F4> :!cscope -Rbq<cr>:cs reset<cr>:call ReConnectCscope()<cr><cr><cr>
nmap gj <Plug>(GitGutterNextHunk)
nmap gk <Plug>(GitGutterPrevHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)
nmap <leader>cs :cs find s 
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
"map <silent><C-j> :execute TabLeft()<CR>
"map <silent><C-k> :execute TabRight()<CR>

" <=== MAPPING

" COMMAND ===>

" before exec in the cmd of vim: helptags ~/.vim/doc/
command! MyHelp help myhelp
command! MyVimHelp help myvimhelp

" <=== COMMAND

let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
