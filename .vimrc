set nocompatible
" Show line numbers
set number
set hidden
set wildchar=<Tab> wildmenu wildmode=full
syntax on
" Highlight matching search strings
set hlsearch
set incsearch
colorscheme torte
" Copy paste
:set clipboard=unnamedplus
" Open window to the right
set splitright

set noswapfile
set list listchars=tab:»·,trail:·,extends:#
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set cursorline

" Too slow on big projects..
"set path+=**

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

nmap mf :lgetexpr system("gop search --name " . expand('<cword>') . " --file " . expand('%:p'))<CR> :lopen<CR>

" jk is escape
inoremap jk <esc>

"Workaround for logipat mapping ELP which shadows :E
let g:loaded_logipat = 1

" Filesystem browser
filetype plugin on
let g:netrw_banner=0    " Skip banner on top
"let g:netrw_liststyle=3 " default to tree, toggle with i, pick root gn
"let g:netrw_list_hide=netrw_gitignore#Hide()

" Snippets
" For C
nnoremap ,csvf :-read $HOME/vimsnippets/c/static_void_func<cr>2wi
nnoremap ,csf :-read $HOME/vimsnippets/c/static_func<cr>wi
nnoremap ,cis :-read $HOME/vimsnippets/c/include_sys<cr>f<a
nnoremap ,cil :-read $HOME/vimsnippets/c/include_loc<cr>f"a
nnoremap ,cif :-read $HOME/vimsnippets/c/if<cr>f(a
nnoremap ,cel :-read $HOME/vimsnippets/c/else<cr>ji

" Use a local viminfo instead of global as default,
" I usually start vim in project dir  and most of the
" stuff in viminfo only makes sense to a speciffic
" project.
"set viminfo+=n./viminfo


" Language Server Protocol support
" Go
augroup LspGo
    au!
    autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'go-lang',
      \ 'cmd': {server_info->['go-langserver']},
      \ 'whitelist': ['go'],
      \ })
    autocmd FileType go setlocal omnifunc=lsp#complete
    autocmd FileType go nmap <buffer> gd <plug>(lsp-definition)
augroup END


