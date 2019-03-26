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

"Plug
call plug#begin('~/.vim/plugged')
Plug 'w0rp/ale'
Plug 'morhetz/gruvbox'
Plug 'tyru/skk.vim'
Plug 'tpope/vim-surround'
Plug 'lervag/vimtex'
Plug 'vim-jp/vimdoc-ja'
Plug 'mbbill/undotree'
Plug 'scrooloose/nerdtree'
Plug 'simeji/winresizer'
Plug 'FrozenPigs/vim-hy'
Plug 'echuraev/translate-shell.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'vim-jp/vim-vimlparser'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'othree/yajs.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
call plug#end()

syntax on

"Trans
let g:trans_bin = expand('~/.vim/bin')

"Undotree
if has('persistent_undo')
    set undodir=~/.undodir/
    set undofile
endif

"ALE
let g:ale_linters = {
\   'rust': ['cargo', 'rls'],
\   'python': ['pyls']
\}
let g:ale_rust_rls_toolchain = 'stable'
let g:ale_fixers = {
\   'asciidoc': ['textlint'],
\   'tex': ['textlint'],
\   'typescript': ['eslint', 'prettier'],
\   'javascript': ['eslint', 'prettier'],
\}

"LSP

let g:lsp_diagnostics_enabled = 0 

if executable('typescript-language-server')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript'],
        \ })
    autocmd FileType typescript setlocal omnifunc=lsp#complete
endif

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

"Vimtex
let g:vimtex_complete_enable = 1

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

