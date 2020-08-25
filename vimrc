if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif

set shell=/bin/bash

function! PackInit() abort

  packadd minpac

  call minpac#init()

  " minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Add other plugins here.
  call minpac#add('itchyny/lightline.vim')
  call minpac#add('mengelbrecht/lightline-bufferline')
  call minpac#add('nathanaelkane/vim-indent-guides')
  call minpac#add('jeetsukumaran/vim-filebeagle')
  call minpac#add('tomtom/tcomment_vim')
  call minpac#add('tpope/vim-surround')

  " Load the plugins right now. (optional)
  " packloadall

endfunction

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
set tabstop=8
set softtabstop=2
set shiftwidth=2
set smarttab

set laststatus=2
set noshowmode
set showtabline=2 "Always show tabline

" Make hidden chars visible
set list

"set showbreak = ↪\
set listchars=tab:→\ ,nbsp:•,trail:•,extends:⟩,precedes:⟨

"The order matters. This line should come later than vim-colors-solarized settings.
highlight SpecialKey ctermbg=NONE ctermfg=19 cterm=NONE

" CoC Suggestions
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
" End of CoC Suggestions

filetype plugin indent on
syntax enable


"Paste content without pain
map <leader>sp :set paste<cr>p<esc>:set nopaste<cr>

"----- TOGGLE LINE WRAP -----
nmap <silent> <leader>nw :set wrap!<CR>

"-----EDIT / RELOAD .vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>


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
colorscheme solarized

"-----PLUGIN: lightline
let g:bufferline_solo_highlight    = 1
let g:lightline                    = {'colorscheme': 'wombat'}
let g:lightline.tabline            = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.active             = {'left': [['mode', 'paste'],
                                    \          ['gitbranch'], ['readonly', 'filename', 'modified', 'gutentags', 'coc']]
                                    \}

let g:lightline.component_expand   = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type     = {'buffers': 'tabsel'}
let g:lightline.component_function = {'gitbranch': 'FugitiveHead',
                                    \ 'coc': 'CocStatus',
                                    \ 'gutentags': 'gutentags#statusline'
                                    \}
let g:lightline.separator          = { 'left': "\ue0b0", 'right': "\ue0b2" }
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#show_number = 2
let g:lightline#bufferline#number_map = {
                                       \  0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
                                       \  5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'
                                       \}

function! LightlineBufferline()
  call bufferline#refresh_status()
  return [ g:bufferline_status_info.before, g:bufferline_status_info.current, g:bufferline_status_info.after]
endfunction

" ---- PLUGIN: indent guides
nmap <leader>ig :IndentGuidesToggle<cr>
let g:indent_guides_guide_size = 1

"------PLUGIN: tomtom/tcomment_vim
noremap <silent> <Leader>cc :TComment<CR>

" Define user commands for updating/cleaning the plugins.
" Each of them calls PackInit() to load minpac and register
" the information of plugins, then performs the task.
command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()
