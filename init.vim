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

packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('w0rp/ale')
call minpac#add('morhetz/gruvbox')
call minpac#add('tyru/skk.vim')

colorscheme gruvbox

let g:ale_linters = {
 \ 'rust': ['cargo', 'rls']
 \ }

let g:ale_rust_rls_toolchain = 'stable'
let g:ale_completion_enabled = 1
