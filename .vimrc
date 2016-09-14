set nocompatible
" Show line numbers
set number
set hidden
set wildchar=<Tab> wildmenu wildmode=full
syntax on
" Highlight matching search strings
set hlsearch
colorscheme torte
" Copy paste
:set clipboard=unnamedplus
" Open window to the right
set splitright

set noswapfile
set list listchars=tab:»·,trail:·,extends:#
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" Status line
set laststatus=2                             " always show
set statusline=
set statusline+=%-10.3n\                     " buffer number
set statusline+=%f\                          " filename
set statusline+=%h%m%r%w                     " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
set statusline+=%=                           " right align remainder
set statusline+=0x%-8B                       " character value
set statusline+=%-14(%l,%c%V%)               " line, character
set statusline+=%<%P                         " file position

if has("cscope")
    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    " show msg when any other cscope db added
    set cscopeverbose
    " Shortcuts in same window 
    nmap css :cs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap csg :cs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap csc :cs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap cst :cs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap cse :cs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap csf :cs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap csi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap csd :cs find d <C-R>=expand("<cword>")<CR><CR>	
    " Shortcuts, open new vert window
    nmap dss :vert scs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap dsg :vert scs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap dsc :vert scs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap dst :vert scs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap dse :vert scs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap dsf :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap dsi :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap dsd :vert scs find d <C-R>=expand("<cword>")<CR><CR>	
endif

"Workaround for logipat mapping ELP which shadows :E
let g:loaded_logipat = 1


