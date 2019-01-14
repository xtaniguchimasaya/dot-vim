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
let g:trans_bin = expand('~/.vim/bin')

"Undotree
if has('persistent_undo')
    set undodir=~/.undodir/
    set undofile
endif

"ALE
let g:ale_completion_enabled = 1
let g:ale_linters = {
\   'rust': ['cargo', 'rls'],
\   'python': ['pyls']
\}
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

let g:rbpt_max = 7
let g:rbpt_loadcmd_toggle = 0

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

function! Viml2Sexp() range
    let l:viml_code = getline(a:firstline, a:lastline)
    let l:vimlparser = vimlparser#import()
    let l:reader = l:vimlparser.StringReader.new(viml_code)
    let l:parser = l:vimlparser.VimLParser.new()
    let l:compiler = l:vimlparser.Compiler.new()
    let l:hy_code = l:compiler.compile(l:parser.parse(l:reader))
    execute a:firstline.','.a:lastline.'delete'
    echo join(l:hy_code, "\n")
endfunction

"minpac
packadd minpac
call minpac#init()
call minpac#add('ta2gch/minpac', {'type': 'opt', 'submodule': 1})
call minpac#add('w0rp/ale')
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
call minpac#add('mbbill/undotree')
call minpac#add('scrooloose/nerdtree')
call minpac#add('simeji/winresizer')
call minpac#add('FrozenPigs/vim-hy')
let g:cmd2 = '! ' . 'mkdir -p ' . fnamemodify(g:trans_bin, ':p:h')
         \ . '&&' . Download('https://git.io/trans', g:trans_bin . '/trans')
         \ . '&& chmod +x ' . g:trans_bin . '/trans'
call minpac#add('echuraev/translate-shell.vim', {'do': g:cmd2})
call minpac#add('kien/rainbow_parentheses.vim')
call minpac#add('vim-jp/vim-vimlparser')
