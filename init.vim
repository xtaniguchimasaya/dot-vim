set number
set title
set ambiwidth=double
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
autocmd QuickFixCmdPost *grep* cwindow
tnoremap <ESC> <C-\><C-n>

syntax on

packadd minpac
call minpac#init()
call minpac#add('ta2gch/minpac', {'type': 'opt', 'submodule': 1})
call minpac#add('w0rp/ale')
call minpac#add('morhetz/gruvbox')
call minpac#add('tyru/skk.vim')
call minpac#add('tpope/vim-surround')
call minpac#add('sheerun/vim-polyglot')
call minpac#add('vim-jp/vimdoc-ja')
call minpac#add('mattn/webapi-vim')
call minpac#add('mattn/excitetranslate-vim')
call minpac#add('mbbill/undotree')
call minpac#add('scrooloose/nerdtree')
call minpac#add('simeji/winresizer')

try
  colorscheme gruvbox
catch
  colorscheme default 
endtry

"Undotree
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

"ALE
"let g:ale_open_list = 1
let g:ale_completion_enabled = 1
let g:ale_linters = {'rust': ['cargo', 'rls']}
let g:ale_rust_rls_toolchain = 'stable'

"SKK
"let g:skk_marker_white = '!'
"let g:skk_marker_white = '?'
"let g:skk_large_jisyo = '~/.config/nvim/dict/SKK-JISYO.L'
