"" unlet! skip_defaults_vim
"" source $VIMRUNTIME/defaults.vim

let mapleader = "\<Space>"

call plug#begin()
Plug 'sheerun/vim-polyglot'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'christoomey/vim-sort-motion'
Plug 'easymotion/vim-easymotion'
Plug 'w0rp/ale'
call plug#end()

" ale eslint autofix
let g:ale_fixers = { 'javascript': ['eslint'] }
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
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

nmap <leader>1 :LualineBuffersJump 1<CR>
nmap <leader>2 :LualineBuffersJump 2<CR>
nmap <leader>3 :LualineBuffersJump 3<CR>
nmap <leader>4 :LualineBuffersJump 4<CR>
nmap <leader>5 :LualineBuffersJump 5<CR>
nmap <leader>6 :LualineBuffersJump 6<CR>
nmap <leader>7 :LualineBuffersJump 7<CR>
nmap <leader>8 :LualineBuffersJump 8<CR>
nmap <leader>9 :LualineBuffersJump 9<CR>
nmap <leader>0 :LualineBuffersJump 10<CR>
nmap <leader><leader>1 :LualineBuffersJump 11<CR>
nmap <leader><leader>2 :LualineBuffersJump 12<CR>
nmap <leader><leader>3 :LualineBuffersJump 13<CR>
nmap <leader><leader>4 :LualineBuffersJump 14<CR>
nmap <leader><leader>5 :LualineBuffersJump 15<CR>
nmap <leader><leader>6 :LualineBuffersJump 16<CR>
nmap <leader><leader>7 :LualineBuffersJump 17<CR>
nmap <leader><leader>8 :LualineBuffersJump 18<CR>
nmap <leader><leader>9 :LualineBuffersJump 19<CR>
nmap <leader><leader>0 :LualineBuffersJump 20<CR>

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
set noswapfile
set ruler
set listchars=tab:›\ ,eol:¬,space:⋅ " highlight whitespace
set nolist
set wildmenu
set showmatch
set lazyredraw

map p pgvy

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
