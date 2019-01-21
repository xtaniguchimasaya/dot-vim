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

"Vundle
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'w0rp/ale'
Plugin 'morhetz/gruvbox'
Plugin 'tyru/skk.vim'
Plugin 'tpope/vim-surround'
Plugin 'lervag/vimtex'
Plugin 'vim-jp/vimdoc-ja'
Plugin 'mbbill/undotree'
Plugin 'scrooloose/nerdtree'
Plugin 'simeji/winresizer'
Plugin 'FrozenPigs/vim-hy'
Plugin 'echuraev/translate-shell.vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'vim-jp/vim-vimlparser'
call vundle#end()
filetype plugin indent on

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
let g:ale_fixers = {
\   'asciidoc': ['textlint']
\   'typescript': ['eslint', 'prettier']
\}

"SKK
let g:skk_large_jisyo = '~/.vim/dict/SKK-JISYO.L.sorted'
let g:skk_large_jisyo_encoding = 'utf-8'

"colorscheme
try
  colorscheme gruvbox
catch
  colorscheme default 
endtry

"Rainbow Parentheses
let g:rbpt_max = 7
let g:rbpt_loadcmd_toggle = 0

"Script
function! Viml2Sexp() range
    let l:viml_code = getline(a:firstline, a:lastline)
    let l:vimlparser = vimlparser#import()
    let l:reader = l:vimlparser.StringReader.new(viml_code)
    let l:parser = l:vimlparser.VimLParser.new()
    let l:compiler = l:vimlparser.Compiler.new()
    let l:hy_code = l:compiler.compile(l:parser.parse(l:reader))
    let l:hy_code = map(l:hy_code, { index, code -> substitute(code, 'let =', 'let', 'g') })
    let l:hy_code = map(l:hy_code, { index, code -> substitute(code, "'\\([^']*\\)'", '"\1"', 'g') })
    let l:hy_code = map(l:hy_code, { index, code -> substitute(code, '\([^"]\)\([agbsl]\):\(\w*\)', '\1#\2"\3"', 'g') })
    execute a:firstline.','.a:lastline.'delete'
    call append(a:firstline, l:hy_code)
endfunction

