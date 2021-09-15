let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Load Plugins
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'

call plug#end()

"Customize Colors
"set termguicolors
"colorscheme gruvbox
"autocmd vimenter * colorscheme gruvbox
set bg=dark

"Settings
set relativenumber
set number
set ruler
set tabstop=8
set softtabstop=4
set shiftwidth=4
set noexpandtab
set splitbelow
set termwinsize=10x0

"Binds
map <C-N> :NERDTreeToggle<CR>

"Coc.vim
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

