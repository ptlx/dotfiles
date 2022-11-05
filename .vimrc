" show title
set title

" show number
set number relativenumber

" show command
set showcmd

" scroll margin
set scrolloff=5

" show cursorline
set cursorline

" indent
set autoindent
set smartindent
set cindent

" search
set ignorecase
set smartcase
set incsearch
set hlsearch
set wrapscan

" no swap and backup
set noswapfile
set nobackup

" hidden
set hidden

" key map
let mapleader = "\<space>"
inoremap jk <ESC>:w<CR>
nnoremap <Leader>% :source<space>%<CR>
nnoremap <Leader><ESC> :nohlsearch<CR>
nnoremap ss :split<CR>
nnoremap sv :vsplit<CR>
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap U <C-r>
nnoremap + <C-a>
nnoremap - <C-x>
nnoremap <C-a> gg<S-v>G

" required
nnoremap <Left> <C-w>h
nnoremap <Down> <C-w>j
nnoremap <Up> <C-w>k
nnoremap <Right> <C-w>l
inoremap <Left> <None>
inoremap <Down> <None>
inoremap <Up> <None>
inoremap <Right> <None>
vnoremap <Left> <None>
vnoremap <Down> <None>
vnoremap <Up> <None>
vnoremap <Right> <None>

" plugin

packadd vim-jetpack
call jetpack#begin()
Jetpack 'tani/vim-jetpack', {'opt': 1}
Jetpack 'easymotion/vim-easymotion'
Jetpack 'morhetz/gruvbox'
call jetpack#end()

" plugin key map
nmap <Leader>w <Plug>(easymotion-overwin-w)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" colorscheme
colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark = 'hard'
highlight Normal ctermbg=NONE
highlight NonText ctermbg=NONE
highlight SpecialKey ctermbg=NONE
highlight EndOfBuffer ctermbg=NONE
