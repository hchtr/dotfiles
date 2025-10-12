syntax on
set number
set tabstop=1
set shiftwidth=1
set autoindent
set expandtab
set termguicolors
colo default

inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i

set hlsearch
set incsearch
set ignorecase

nnoremap <F5> :w<CR>:!clear && g++ -ggdb -O0 -pedantic-errors -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion -Werror -std=c++17 % -o %<.debug && ./%<.debug<CR>
nnoremap <F6> :w<CR>:!clear && g++ -O2 -DNDEBUG -pedantic-errors -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion -Werror -std=c++17 % -o %<.release && ./%<.release<CR>
