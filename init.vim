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
if has("mac")
    call minpac#add('tyru/eskk.vim', {'do': 'curl https://api.github.com/repos/skk-dev/dict/tarball | tar -C ~/.vim -s "s%[^/]*%dict%" -zxf -'})
elseif has("unix")
    call minpac#add('tyru/eskk.vim', {'do': 'wget -O- https://api.github.com/repos/skk-dev/dict/tarball | tar -C ~/.vim --transform "s%[^/]*%dict%" -zxf -'})
endif
call minpac#add('tpope/vim-surround')
call minpac#add('sheerun/vim-polyglot')
call minpac#add('vim-jp/vimdoc-ja')
call minpac#add('mattn/webapi-vim')
call minpac#add('mbbill/undotree')
call minpac#add('scrooloose/nerdtree')
call minpac#add('simeji/winresizer')
if has('mac')
    call minpac#add('echuraev/translate-shell.vim', {'do': 'curl git.io/trans > ~/.vim/bin/trans && chmod +x ~/.vim/bin/trans'})
elseif has('unix')
    call minpac#add('echuraev/translate-shell.vim', {'do': 'wget -O- git.io/trans > ~/.vim/bin/trans && chmod +x ~/.vim/bin/trans'})
endif

try
  colorscheme gruvbox
catch
  colorscheme default 
endtry

"Trans
let g:trans_bin = "~/.vim/trans"

"Undotree
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

"ALE
let g:ale_completion_enabled = 1
let g:ale_linters = {'rust': ['cargo', 'rls']}
let g:ale_rust_rls_toolchain = 'stable'

"ESKK
let g:eskk#large_dictionary = '~/.config/nvim/dict/SKK-JISYO.L'
