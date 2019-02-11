set nocompatible
set shell=/bin/bash

call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'jeetsukumaran/vim-filebeagle'
Plug 'mgee/lightline-bufferline'
Plug 'itchyny/lightline.vim'
"Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'
Plug 'tomtom/tcomment_vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'w0rp/ale'
Plug 'prettier/vim-prettier'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'suan/vim-instant-markdown'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv', {'on': ['Gitv']}
Plug 'Valloric/YouCompleteMe'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ap/vim-css-color'
"Plug 'terryma/vim-multiple-cursors'
Plug 'kannokanno/previm'
Plug 'christoomey/vim-tmux-navigator'
Plug 'posva/vim-vue'
Plug 'digitaltoad/vim-pug'
Plug 'cakebaker/scss-syntax.vim'
Plug 'junegunn/goyo.vim'
Plug 'iamcco/markdown-preview.vim'

call plug#end()

let mapleader = "\<space>"
inoremap jk <ESC>

set clipboard=unnamed  " Set clipboard to system clipboard
set encoding=utf-8    " Set file encoding to utf-8
set hidden               " Open another file for editing without saving another.
set lazyredraw           " Don’t update screen during macro and script execution.
set number
set backspace=indent,eol,start   "backspace through anything
set complete-=i
set ruler
set wildmenu
set formatoptions+=j "remove comment char when joining lines
set autoread  "reload file if it is changed outside of vim
set history=1000
set tabpagemax=50
set nrformats-=octal
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*.png,*.jpg,*.bmp,*.gif,*.exe

set sidescrolloff=5
set scrolloff=1

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab

filetype plugin indent on
syntax enable

"----- TOGGLE LINE WRAP -----
nmap <silent> <leader>nw :set wrap!<CR>

"-----EDIT / RELOAD .vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

"syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" It seems that vim does not handle sucessive calls of the match command gracefully. Since BufWinEnter commands are executed every time a buffer is displayed (i.e., switching to another file), the match command is executed many times during a vim session. This seems to lead to a memory leak which slowly impacts performance (for example scrolling and writing become unbearably slow). Include the following line to fix the issue:

"1 [http://vim.wikia.com/wiki/Highlight_unwanted_spaces]
autocmd BufWinLeave * call clearmatches()

"------UNDO/SWP/BACKUP DIRS-----
set undofile
set undodir=~/.vim/.undo//
set directory=~/.vim/.swp//
set backupdir=~/.vim/.backup//

"------BUFFER NAVIGATION
nmap <leader>h :bprevious<cr>
nmap <leader>l :bnext<cr>
nmap <leader>q :bdelete<cr>


"------MOVE AROUND-----
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

noremap j gj
noremap k gk

"-----SPLIT SCREEN----
nnoremap <silent> vv <C-w>v
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

"-----SEARCH------
set ignorecase
set incsearch
set showmatch
set hlsearch

vnoremap // y/<C-R>"<CR>
"Clean search highlights
nnoremap <leader>, :noh<cr>

"-----PLUGIN: vim-colors-solarized
set background=dark
let g:solarized_visibility = "high"
let g:solarized_contrast   = "high"
let g:solarized_termcolors = 256
let g:solarized_termtrans  = 1
colorscheme solarized

"-----PLUGIN: lightline
let g:bufferline_solo_highlight    = 1
let g:lightline                    = {'colorscheme': 'solarized'}
let g:lightline.tabline            = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.active             = {'left': [['mode', 'paste'],
                                    \          ['gitbranch', 'readonly', 'filename', 'modified']]
                                    \}
let g:lightline.component_expand   = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type     = {'buffers': 'tabsel'}
let g:lightline.component_function = {'gitbranch': 'fugitive#head'}
let g:lightline.separator          = { 'left': "\ue0b0", 'right': "\ue0b2" }

function! LightlineBufferline()
  call bufferline#refresh_status()
  return [ g:bufferline_status_info.before, g:bufferline_status_info.current, g:bufferline_status_info.after]
endfunction

set laststatus=2
set noshowmode
set showtabline=2 "Always show tabline

" Make hidden chars visible
set list
"set showbreak = ↪\
set listchars=tab:→\ ,nbsp:•,trail:•,extends:⟩,precedes:⟨

"The order matters. This line should come later than vim-colors-solarized settings.
highlight SpecialKey ctermbg=NONE ctermfg=19 cterm=NONE

"------PLUGIN: sheerun/vim-polyglot

"------PLUGIN: tomtom/tcomment_vim
noremap <silent> <Leader>cc :TComment<CR>

"------PLUGIN: gitgutter
"Turned off by default
let g:gitgutter_enabled = 0
nmap <leader>gg : GitGutterToggle<CR>

"------PLUGIN: w0rp/ale
let g:ale_linters              = { 'javascript': ['eslint'], 'python':['flake8','pylint'] }
let g:ale_fixers               = { 'javascript': ['prettier'], 'python':['autopep8','isort','black'] }

"autocmd BufWritePre,TextChanged,InsertLeave *.js,*.css,*.scss,*.less ALEFix

nmap <leader>jf : ALEFix<CR>

let g:ale_lint_on_insert_leave = 1
let g:ale_completion_enabled   = 1
let g:ale_sign_column_always   = 1
let g:ale_sign_error           = '>>'
let g:ale_sign_warning         = '--'

"------PLUGIN: godlygeek/tabular
vnoremap <silent> <Leader>cee : Tabularize /=<CR>
vnoremap <silent> <Leader>cet : Tabularize /#<CR>
vnoremap <silent> <Leader>ce  : Tabularize /

"------PLUGIN: mattn/emmet-vim
"let g:user_emmet_leader_key='<C-y>'

"------PLUGIN : VIM-GO ------
autocmd FileType go nmap <leader>r :<C-u>GoRun %<cr>
autocmd FileType go nmap <leader>b :<C-u>GoBuild %<cr>

"-----PLUGIN : YouCompleteMe
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

au FileType php set omnifunc=phpcomplete#CompletePHP

"-----PLUGIN: previm
let g:previm_open_cmd = 'open -a Safari'

"-----PLUGIN: markdown syntax
let g:vim_markdown_folding_disabled = 1
map üü <Plug>Markdown_MoveToNextHeader
map ğğ <Plug>Markdown_MoveToPreviousHeader

"---- PLUGIN: indent guides
nmap <leader>ig :IndentGuidesToggle<cr>
let g:indent_guides_guide_size = 1
"let g:indent_guides_color_change_percent = 3
"---- PLUGIN: ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\'

"---- POSVA / VIM-VUE
" let g:vue_disable_pre_processors=1
"
"--- PLUGIN: markdown_preview
" Open preview

let python_highlight_all=1
map <leader>mp :MarkdownPreview<cr>
map <leader>mc :StopMarkdownPreview<cr>

" Django Template tags "
map <leader>%% i{% block  %}<cr><cr>{% endblock %}<esc>2k2hi
map <leader>%i i{% include "" %}<esc>3hi
map <leader>sp :set paste<cr>p<esc>:set nopaste<cr>
inoremap %% {%   %}<esc>3h
