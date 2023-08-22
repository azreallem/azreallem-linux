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
set mouse=r
set hlsearch
set autoindent
set nu
set ru
set wildmenu
"set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936

" <=== NORMAL



" THEME ===>

colorscheme desert
set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40
"" Highlight cursor line underneath the cursor horizontally.
"highlight CursorLine cterm=NONE ctermbg=grey guibg=NONE guifg=NONE
"set cursorline

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

map <silent><C-j> :execute TabLeft()<CR>
map <silent><C-k> :execute TabRight()<CR>

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

nnoremap <F4> :call GitDiff()<cr>

" <=== FUNCTIONS


" PLUGIN ===>

" vim_markdown Plugin
let g:vim_markdown_folding_disabled = 1

" gitgutter Plugin
set foldtext=gitgutter#fold#foldtext()
let g:gitgutter_use_location_list = 0
set updatetime=100
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)

" <=== PLUGIN



" MAPPING ===>

nmap <F1> :cscope help<cr>:cs find 
nmap <F2> :cscope help<cr>:tab cs find 
nnoremap <F3> :GitGutterQuickFix<cr>:copen<cr>
" map <F5> :!cscope.sh<CR>:cs reset<CR><CR>
map <F12> : call ReConnectCscope()<cr>
set pastetoggle=<F9>
nmap gj <Plug>(GitGutterNextHunk)
nmap gk <Plug>(GitGutterPrevHunk)

" <=== MAPPING

" cscope

noremap <leader>cs :cs find s 
noremap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
noremap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
noremap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
noremap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
noremap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
noremap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
noremap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
noremap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>

