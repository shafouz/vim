" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"filetype plugin indent on

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

runtime macros/matchit.vim

set directory^=$HOME/.vim/tmp//
set nocp
filetype plugin on

set termguicolors
set tabstop=2 shiftwidth=2 expandtab

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

let html_no_rendering=1
"========== hotkeys ==========
nnoremap <silent> <C-f> :FZF<CR>

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap jj <esc>

nnoremap <F5> :!clear<CR>:w<CR>:!cargo run %<CR>
inoremap <F5> <Esc>:!clear<CR>:w<CR>:!cargo run %<CR>

nnoremap <F6> :!clear<CR>:w<CR>:!cargo test %<CR>
inoremap <F6> <Esc>:!clear<CR>:w<CR>:!cargo test %<CR>
"=============================
set norelativenumber number

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'https://github.com/junegunn/fzf.vim'
Plug 'https://github.com/BurntSushi/ripgrep'
Plug 'dracula/vim'
Plug 'https://github.com/lifepillar/vim-solarized8'
Plug 'posva/vim-vue'
Plug 'https://github.com/tpope/vim-eunuch'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'rust-lang/rust.vim'

call plug#end()

set number
set background=dark
colorscheme solarized8

"=======ctags=======
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
map <Leader>rt :!ctags --tag-relative --extra=+f -Rf.git/tags --exclude=.git --exclude=node_modules --languages=-javascript,sql<CR><CR>
set tags+=.git/tags

"=======coc========
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
