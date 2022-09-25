"" unlet! skip_defaults_vim
"" source $VIMRUNTIME/defaults.vim

let mapleader = "\<Space>"

call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

" ale eslint autofix
let g:ale_fixers = { 'javascript': ['eslint'] }
let g:ale_fix_on_save = 0
map <leader>l :ALEToggle<CR>

let g:sort_motion_flags = 'ui'

" plug shortcuts
nmap <leader>pi :PlugInstall<CR>
nmap <leader>pu :PlugUpdate<CR>
nmap <leader>pc :PlugClean<CR>

" vim-fugitive show git diff side-by-side
map <leader>gd :Gvdiff<CR>
map <leader>gb :Git blame<CR>

" easymotion greatly improves default f functionality
map f <Plug>(easymotion-bd-f)
" easymotion ignore case on search
let g:EasyMotion_smartcase = 1

map - :vertical resize -5<CR>
map = :vertical resize +5<CR>
map _ :resize -5<CR>
map + :resize +5<CR>
map H <C-w>h
map K <C-w>k
map J <C-w>j
map L <C-w>l

syntax on
colorscheme nordfox

filetype indent on " turn auto indent on
set tabstop=4 " set tab size in spaces (manual indenting)
set shiftwidth=4 " number of spaces inserted for tab (auto indenting)
set expandtab " convert tabs to spaces
set number " turn on line numbers
set ignorecase " ignore case on search by default
set nowrap " turn off word wrap
set diffopt+=iwhite
set mouse=a
set clipboard+=unnamed
set colorcolumn=80 " highlight column 80
set cursorline
set noswapfile
set ruler
set listchars=tab:›\ ,eol:¬,space:⋅ " highlight whitespace
set nolist
set wildmenu
set showmatch
set lazyredraw

map <leader>o :NvimTreeToggle<CR>
map <leader>f :Files<CR>
map <leader>gf :GF?<CR>
map <leader>/ :execute 'Rg ' . input('Rg/')<CR>
map <leader>w :w<CR>
map <leader>bd :bd<CR>
map <leader>bwd :w<CR>:bd<CR>
map <leader>X :x<CR>
map <leader>bD :bd!<CR>
map <leader>bad :%bd<CR>
map <leader>Q :q!<CR>
map <leader>r :source ~/.config/nvim/init.lua<CR>
map vat va<
map vit vi<
map dat da<
map dit di<
map cat ca<
map cit ci<

map <leader>ev :vsplit 
map <leader>eh :split 
map <leader>v <C-w>v
map <leader>s <C-w>s
map <leader>qp <C-w>q

hi InactiveWindow guibg=#181e2a
set winhighlight=NormalNC:InactiveWindow
