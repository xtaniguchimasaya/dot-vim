set number
set title
set tabstop=4
set expandtab
set shiftwidth=4
set smartindent
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set virtualedit=block
set backspace=indent,eol,start
set breakindent
set t_Co=256
set background=dark

syntax on
colorscheme gruvbox

"LSP

let g:lsp_signs_enabled = 1
let g:lsp_diagonstics_echo_cursor = 1
let g:lsp_signs_error = {'text': '!'}
let g:lsp_signs_warning = {'text': '?'}
let g:lsp_signs_hint = {'text': '*'}

nnoremap <Leader>d :LspDefinition<CR>
nnoremap <Leader>f :LspDocumentFormat<CR>
nnoremap <Leader>e :LspDocumentDiagnostics<CR>
nnoremap <Leader>r :LspRename<CR>

"C/C++ (clangd)
if executable('clangd')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
    autocmd FileType c setlocal omnifunc=lsp#complete
    autocmd FileType cpp setlocal omnifunc=lsp#complete
    autocmd FileType objc setlocal omnifunc=lsp#complete
    autocmd FileType objcpp setlocal omnifunc=lsp#complete
endif

"Python (python-language-server)
if executable('pyls')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
    autocmd FileType python setlocal omnifunc=lsp#complete
endif

"JavaScript/TypeScript
if executable('typescript-language-server')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->['typescript-language-server']},
        \ 'whitelist': ['typescript','javascript'],
        \ })
    autocmd FileType javascript setlocal omnifunc=lsp#complete
    autocmd FileType typescript setlocal omnifunc=lsp#complete
endif

"Clojure (clojure-lsp)
if executable('clojure-lsp')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'clojure-lsp',
        \ 'cmd': {server_info->['clojure-lsp']},
        \ 'whitelist': ['clojure'],
        \ })
    autocmd FileType clojure setlocal omnifunc=lsp#complete
endif
