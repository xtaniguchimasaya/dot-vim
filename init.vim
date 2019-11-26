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
set spell
set spelllang=en,cjk
autocmd QuickFixCmdPost *grep* cwindow
tnoremap <ESC> <C-\><C-n>

"Vundle
filetype off
call plug#begin('~/.vim/plugged')
Plug 'dense-analysis/ale'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-surround'
Plug 'vim-jp/vimdoc-ja'
Plug 'mbbill/undotree'
Plug 'echuraev/translate-shell.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'tyru/eskk.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'rhysd/reply.vim'
Plug 'sheerun/vim-polyglot'
call plug#end()

syntax on

"Spell
autocmd Syntax tex syntax match URL /https\?:\/\/[a-zA-Z\/_.#?=-]*/ contains=@NoSpell
autocmd Syntax tex syntax cluster Spell add=URL

"Trans
let g:trans_bin = expand('~/.vim/bin')

"Undotree
set undodir=~/.undodir/
set undofile

"ALE
set omnifunc=ale#completion#OmniFunc
let g:ale_completion_tsserver_autoimport = 1
let g:ale_fixers = {
    \   'javascript': ['eslint'],
    \   'typescript': ['eslint'],
    \   'python': ['generic_python'],
    \   'cpp': ['clangfmt'],
    \   'go': ['gofmt'],
    \   'json': ['jq'],
    \ }

"ESKK
let g:eskk#large_dictionary = "~/.config/nvim/dict/SKK-JISYO.L"
let g:eskk#marker_henkan = "?"
let g:eskk#marker_henkan_select = "!"

"colorscheme
try
  colorscheme gruvbox
catch
  colorscheme default 
endtry

"Rainbow Parentheses
let g:rbpt_max = 7
let g:rbpt_loadcmd_toggle = 0
