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


" auto update configure of ~/.vimrc
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" enable fiee type detection
:filetype on
:filetype plugin on

syntax on
set laststatus=2
set mouse=r
set paste


" enable hightlight search
set hlsearch
" set cursorline
set autoindent
set nu
set paste

" theme


" others
" set background=dark
set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936
highlight LineNr term=bold cterm=NONE ctermfg=Grey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" vim_markdown Plugin
let g:vim_markdown_folding_disabled = 1


" mapping
map gh :browse oldfiles<CR>

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

" ale Plugin
"nmap <silent> <C-n> <Plug>(ale_next_wrap)
"" let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_enter = 0
"let g:ale_linters = {
"\   'c++': ['g++'],
"\   'c': ['gcc'],
"\   'python': ['pylint'],
"\}
"map <silent><F3> :ALEToggle<CR>:set nu<CR>
"map <silent><F4> :ALEDisable<CR>:set nonu<CR>

" hi Over80 guifg=fg guibg=Blue
" au BufNewFile,BufRead *.* match Over80 '\%>80v.*'
" set colorcolumn=81
" let &colorcolumn=join(range(1,80),",")."80,".join(range(81,9999),",")
set background=dark
"

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

function GitDiff()
    :silent write
    :silent execute '!git diff --color=always -- ' . expand('%:p') . ' | less --RAW-CONTROL-CHARS'
    :redraw!
endfunction

let g:gitgutter_use_location_list = 0
set updatetime=100
nmap gj <Plug>(GitGutterNextHunk)
nmap gk <Plug>(GitGutterPrevHunk)

"function! GitStatus()
"  let [a,m,r] = GitGutterGetHunkSummary()
"  return printf('+%d ~%d -%d', a, m, r)
"endfunction
"set statusline+=%{GitStatus()}

" Highlight cursor line underneath the cursor horizontally.
highlight CursorLine   cterm=NONE ctermbg=grey guibg=NONE guifg=NONE
set cursorline

nmap <F1> :cscope help<cr>:cs find 
nmap <F2> :cscope help<cr>:vert scs find 
nnoremap <F3> :GitGutterQuickFix<cr>:copen<cr>
nnoremap <F4> :call GitDiff()<cr>
