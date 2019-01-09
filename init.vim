set number
set title
set encoding=utf-8
set fileencodings=utf-8
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

"Trans
let g:trans_bin = expand('~/.vim/bin/trans')

"Undotree
if has('persistent_undo')
    set undodir=~/.undodir/
    set undofile
endif

"ALE
let g:ale_completion_enabled = 1
let g:ale_linters = {'rust': ['cargo', 'rls']}
let g:ale_rust_rls_toolchain = 'stable'
let g:ale_fixers = {'asciidoc': ['textlint']}

"SKK
let g:skk_large_jisyo = '~/.vim/dict/SKK-JISYO.L.sorted'
let g:skk_large_jisyo_encoding = 'utf-8'

"ESKK
let g:eskk#large_dictionary = g:skk_large_jisyo

"colorscheme
try
  colorscheme gruvbox
catch
  colorscheme default 
endtry

function! Download(src, dest)
    if has('mac')
        return 'curl -sL "' . a:src . '" -o "' . a:dest . '"'
    elseif has('unix')
        return 'wget -q "' . a:src . '" -O "' . a:dest . '"'
    endif
endfunction

function! Tar(...)
    if has('mac')
        return 'gtar ' . join(a:000, ' ')
    elseif has('unix')
        return 'tar ' . join(a:000, ' ')
    endif
endfunction

"minpac
packadd minpac
call minpac#init()
call minpac#add('ta2gch/minpac', {'type': 'opt', 'submodule': 1})
call minpac#add('ta2gch/ale')
call minpac#add('morhetz/gruvbox')
let g:cmd1 = '!' . Download('https://api.github.com/repos/skk-dev/dict/tarball', '-')
         \ . '|' . Tar('-C', expand('~/.vim'), '--transform', 's/[^\\/]*/dict/', '-zxf', '-')
         \ . '&& cat ~/.vim/dict/SKK-JISYO.L'
         \ . ' | iconv -f EUCJP -t UTF8'
         \ . ' | grep -v ";;"'
         \ . ' | sort'
         \ . ' | tee ' . g:skk_large_jisyo
         \ . ' > ' . g:eskk#large_dictionary
"call minpac#add('tyru/eskk.vim', {'do': g:cmd1})
call minpac#add('tyru/skk.vim', {'do': g:cmd1})
call minpac#add('tpope/vim-surround')
call minpac#add('sheerun/vim-polyglot')
call minpac#add('vim-jp/vimdoc-ja')
call minpac#add('mattn/webapi-vim')
call minpac#add('mbbill/undotree')
call minpac#add('scrooloose/nerdtree')
call minpac#add('simeji/winresizer')
let g:cmd2 = '! ' . 'mkdir -p ' . fnamemodify(g:trans_bin, ':p:h')
         \ . '&&' . Download('https://git.io/trans', g:trans_bin)
         \ . '&& chmod +x ' . g:trans_bin
call minpac#add('echuraev/translate-shell.vim', {'do': g:cmd2})

