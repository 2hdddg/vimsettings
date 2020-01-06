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

set colorcolumn=80

set nomodeline

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

set signcolumn=auto

" Go
" Want tabs
autocmd FileType go setlocal noexpandtab


" Language Server Protocol support
" Go
augroup LspGo
    au!

    if executable('gopls')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'gopls',
            \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
            \ 'whitelist': ['go'],
            \ })
    endif
    autocmd FileType go setlocal omnifunc=lsp#complete
    autocmd FileType go autocmd BufWritePre <buffer> silent! LspDocumentFormatSync
augroup END
" Java
augroup LspJava
    au!
    au User lsp_setup call lsp#register_server({
        \ 'name': 'jdt',
        \ 'cmd': {server_info->['java', '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        \ '-Dosgi.bundles.defaultStartLevel=4', '-Declipse.product=org.eclipse.jdt.ls.core.product',
        \ '-noverify', '-Xmx1G', '-XX:+UseG1GC', '-XX:+UseStringDeduplication', '-jar',
        \ '/home/peter/code/jdt-language-server/plugins/org.eclipse.equinox.launcher_1.5.600.v20191014-2022.jar',
        \ '-configuration', '/home/peter/code/jdt-language-server/config_linux', '-data', '/home/peter/code/jdt-language-server/workspace' ]},
        \ 'whitelist': ['java'],
        \ })
augroup END

" General lsp definitions
nmap ,d <plug>(lsp-definition)
nmap ,h <plug>(lsp-hover)
nmap ,r <plug>(lsp-references)
nmap ,n <plug>(lsp-rename)
nmap ,s <plug>(lsp-document-symbol)
" Show info on current line in normal mode
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_enabled = 1
" Annoying auto popup...
let g:lsp_signature_help_enabled = 0

" Make completion in normal mode behave a bit like ctrlp
inoremap <expr> <C-j>
 \ pumvisible() ? "\<C-n>" : asyncomplete#force_refresh()
inoremap <expr> <C-k>     pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr> <CR>      pumvisible() ? "\<C-y>" : "\<CR>"
" Don't auto complete all the time
let g:asyncomplete_auto_popup = 0
