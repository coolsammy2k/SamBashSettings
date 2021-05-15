" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif


call plug#begin('~/.vim/plugged')   "Installing Vim Plugins
     Plug 'vim-airline/vim-airline' "Setting up my status bar
     Plug 'vim-airline/vim-airline-themes'
    " Plug 'airblade/vim-gitgutter' "Shows changes if you're working with git
     Plug 'scrooloose/nerdtree'     

     "Syntax 
     Plug 'morhetz/gruvbox'       
     Plug 'joshdick/onedark.vim'
     Plug 'sainnhe/edge'


     Plug 'nathanaelkane/vim-indent-guides'
     Plug 'yggdroot/indentline'

     "SuperTab
     Plug 'ervandew/supertab'

     Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
     Plug 'junegunn/fzf.vim'

call plug#end()

set encoding=UTF-8
syntax on "Turning Syntax on
set wildmenu "Tab completion everywhere
"set number relativenumber 
"set nu rnu
set backspace=indent,eol,start    "Making sure backspace works
set noruler "setting up rulers & spacing, tabs
set confirm
set shiftwidth=4
set autoindent
set smartindent
set tabstop=4
set expandtab
set hls is "Making sure search highlights words as we type them
set ic
set laststatus=2 "Setting the size for the command area and airline status bar
set cmdheight=2
set hidden      "Allow to change buffers without writing to buffers

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" Let your leader key to comma , 
"let mapleader = ","
nnoremap <silent> <leader>n :nohlsearch<CR>

"Key re-maps
map <C-n> :Lex!<CR>
map <C-l> :vertical resize 30<CR>
map <C-u> :source ~/.vimrc<CR>
nnoremap <Up>	:resize +2<CR>
nnoremap <Down>	:resize -2<CR>
nnoremap <Left>	:rvertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

"Move lines up down using control key i,j,k in visual, normal mode

" Normal mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==

" Insert mode
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi

" Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv


"Color schemes need to be below everything else that effects color apparently.
"If no thing will load out of order and not work properly
"colorscheme gruvbox "Setting up Gruvbox and airline, (colors)
"colorscheme onedark
colorscheme gruvbox
