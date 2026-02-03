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